
require "test_helper"

class RefreshTokenTest < ActionDispatch::IntegrationTest
    def setup
        # @user = active_user
        # byebug
        @user = User.create(nickname: "test taro", email: "example@example.com0", password: "password")
        @encode = UserAuth::RefreshToken.new(user_id: @user.id)
        @lifetime = UserAuth.refresh_token_lifetime
    end

    # エンコード
    test "encode_token" do
        # payload[:exp]の値は想定通りか(1秒許容)
        payload = @encode.payload
        expect_lifetime = @lifetime.from_now.to_i
        assert_in_delta expect_lifetime, payload[:exp], 1.second

        # payload[:jti]の値は想定通りか
        encode_user = @encode.entity_for_user
        expect_jti = encode_user.refresh_jti
        assert_equal expect_jti, payload[:jti]

        # payload[:sub]の値は想定通りか
        user_claim = @encode.send(:user_claim)
        assert_equal @encode.user_id, payload[user_claim]
    end

    # デコード
    test "decode_token" do
        decode = UserAuth::RefreshToken.new(token: @encode.token)
        payload = decode.payload

        # デコードユーザーは一致しているか
        token_user = decode.entity_for_user
        assert_equal @user, token_user

        # verify_claimsは想定通りか
        verify_claims = decode.send(:verify_claims)
        assert verify_claims[:verify_expiration]
        assert_equal UserAuth.token_signature_algorithm,
                    verify_claims[:algorithm]

        # 有効期限後トークンはエラーを吐いているか
        travel_to (@lifetime.from_now) do
            assert_raises JWT::ExpiredSignature do
                UserAuth::RefreshToken.new(token: @encode.token)
            end
        end

        # トークンが書き換えられた場合エラーを吐いているか
        invalid_token = @encode.token + "a"
        assert_raises JWT::VerificationError do
            UserAuth::RefreshToken.new(token: invalid_token)
        end
    end

    # デコードオプション
    test "verify_claims" do
        @user.reload
        assert_equal @user.refresh_jti, @encode.payload[:jti]

        # userのjtiが正常の場合
        assert UserAuth::RefreshToken.new(token: @encode.token)

        # userのjtiが不正な場合
        @user.remember("invalid")
        e = assert_raises JWT::InvalidJtiError do
            UserAuth::RefreshToken.new(token: @encode.token)
        end
        # エラーメッセージをtestする場合
        assert_equal "Invalid jti", e.message

        # userにjtiが存在しない場合
        @user.forget
        @user.reload
        assert_nil @user.refresh_jti
        assert_raises JWT::InvalidJtiError do
            UserAuth::RefreshToken.new(token: @encode.token)
        end
    end
end
