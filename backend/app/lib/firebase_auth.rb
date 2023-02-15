require 'jwt'
require 'net/http'

# firebaseの検証を実施
# 2回デコードする必要がある。
#  (1回目:token署名を検証するための公開鍵を特定, 2回目:公開鍵を使って再度デコード)

# tokenをdecodeして中身を取得
# 取得したheaderを使って、公開鍵を取得する
# 公開鍵を使って、tokenを検証
# token検証に失敗したら、error情報を返す
# token検証い成功したら、user情報を返す

module FirebaseAuth
    ALGORITHM = "RS256".freeze

    # issは ↓ + FIREBASE_PROJECT_ID
    ISSUER_PREFIX = "https://securetoken.google.com/".freeze
    FIREBASE_PROJECT_ID = ENV["FIREBASE_PROJECTID"]

    # 下記のURLからGoogle公開鍵証明書リストを取得する
    CERT_URI =
        "https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com".freeze

    def verify_id_token(id_token)
        payload, header = decode_unverified(id_token)
        public_key = get_public_key(header)

        error = verify(id_token, public_key)

        if errors.empty?
            # return { uid: payload["user_id"] }
            return {
                uid: payload["user_id"],
                nickname: payload["name"],
                # avatar: payload["picture"],
            }
        else
            return { errors: errors.join(" / ") }
        end
    end

    private

    # 検証せずトークンをデコード
    # verify部分をfalseにすることで、検証をスキップしてデコードを行う（参照：https://github.com/jwt/ruby-jwt/issues/216#issuecomment-319010415）
    # これによりヘッダ部分から公開鍵識別子を取得し、署名検証に必要な公開鍵を取得する
    def decode_unverified(token)
        decode_token(
            token: token,
            key: nil,
            verify: false,
            options: {
                algorithm: ALGORITHM,
            },
        )
    end

    def decode_token(token:, key:, verify:, options:)
        JWT.decode(token, key, verify, options)
    end

    # ヘッダの中のkidを用いて公開鍵を取得する
    # Googleの公開鍵はX.509にて作成されているのでそれに従って証明書を作成し、公開鍵を取得する。
    def get_public_key(header)
        certificate = find_certificate(header["kid"])
        _public_key = OpenSSL::X509::Certificate.new(certificate).public_key
    rescue OpenSSL::X509::CertificateError => e
        raise "Invalid certificate. #{e.message}"
        # return public_key
    end

    # 公開鍵が存在する証明書を探すためのkeyがkid
    def find_certificate(kid)
        certificates = fetch_certificates
        unless certificates.keys.include?(kid)
            raise "Invalid 'kid', do not correspond to one of valid public keys."
        end

        # valid_certificate = certificates[kid]
        # return valid_certificate
        _valid_certificate = certificates[kid]
    end

    # CERT_URLから証明書リストを取得する
    def fetch_certificates
        uri = URI.parse(CERT_URI)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true

        req = Net::HTTP::Get.new(uri.path)
        res = https.request(req)
        unless res.code == "200"
            raise "Error: can't obtain valid public key certificates from Google."
        end

        # certificates = JSON.parse(res.body)
        # return certificates
        _certificates = JSON.parse(res.body)
    end

    # 与えられたJWTトークンのフォーマットチェックと検証を行う
    # トークンになにか問題があった場合はエラーを返す
    def verify(token, key)
        errors = []

        begin
            decoded_token =
                decode_token(
                    token: token,
                    key: key,
                    verify: true,
                    options: decode_options,
                )
        rescue JWT::ExpiredSignature
            errors << "Firebase ID token has expired. Get a fresh token from your app and try again."
        rescue JWT::InvalidIatError
            errors << "Invalid ID token. 'Issued-at time' (iat) must be in the past."
        rescue JWT::InvalidIssuerError
            errors << "Invalid ID token. 'Issuer' (iss) Must be 'https://securetoken.google.com/<firebase_project_id>'."
        rescue JWT::InvalidAudError
            errors << "Invalid ID token. 'Audience' (aud) must be your Firebase project ID."
        rescue JWT::VerificationError => e
            errors << "Firebase ID token has invalid signature. #{e.message}"
        rescue JWT::DecodeError => e
            errors << "Invalid ID token. #{e.message}"
        end

        sub = decoded_token[0]["sub"]
        alg = decoded_token[1]["alg"]

        # subject ("sub") と algorithm ("alg")を追加検証する（JWT.decodeで検証できないため）
        # unless sub.is_a?(String) && !sub.empty?
        #     errors << "Invalid ID token. 'Subject' (sub) must be a non-empty string."
        # end
        # unless alg == ALGORITHM
        #     errors << "Invalid ID token. 'alg' must be '#{ALGORITHM}', but got #{alg}."
        # end
        errors << 'Firebase ID token has no "sub" (subject) claim.' unless sub.is_a?(String)
        errors << 'Firebase ID token has an empty string "sub" (subject) claim.'  if sub.empty?
        errors << 'Firebase ID token has "sub" (subject) claim longer than 128 characters.' if sub.size > 128
        errors << "Invalid ID token. 'alg' must be '#{ALGORITHM}', but got #{alg}." unless alg == ALGORITHM


        return errors
    end

    def decode_options
        {
            iss: ISSUER_PREFIX + FIREBASE_PROJECT_ID,
            aud: FIREBASE_PROJECT_ID,
            algorithm: ALGORITHM,
            verify_iat: true,
            verify_iss: true,
            verify_aud: true,
        }
    end

end