# lib以下のものは自動では読み込まれない
require "validator/email_validator"

class User < ApplicationRecord

    # バリデーション直前に実行する
    before_validation :downcase_email

    # bcrypt
    # (暗号化/ passwordとして使用/ password_confirmationも使用可能)
    has_secure_password

    # avatar用 carrierwave
    mount_uploader :avatar, AvatarUploader

    # validate
    # allow_blank: true => エラー内容を何個も出力させない為の処理
    validates :nickname, presence: true,
                length: { maximum: 30, allow_blank: true }
    # validates :email, presence: true, uniqueness: true

    # activedを実装する場合はuniqueness: false不要
    # 認証済み(actived=true && email=true)を検証すると認証していないemailの重複のみ許容する形となる
    validates :email, presence: true,
                email: { allow_blank: true},
                uniqueness: true

    VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
    validates :password, presence: true,
                length: { minimum: 8,
                    allow_blank: true
                },
                format: {
                    with: VALID_PASSWORD_REGEX,
                    message: :invalid_password,
                    allow_blank: true
                },
                allow_nil: true



    ## methods
    # メールのバリデーション設定(メールで検証link等の実装時に必要)
    # class method  ###########################
    # class << self
    #     # emailからアクティブなユーザーを返す
    #     def find_by_activated(email)
    #     find_by(email: email, activated: true)
    #     end
    # end
    # class method end #########################

    # 自分以外の同じemailのアクティブなユーザーがいる場合にtrueを返す
    # def email_activated?
    #     users = User.where.not(id: id)
    #     users.find_by_activated(email).present?
    # end

    # リフレッシュトークンのJWT IDを記憶する
    def remember(jti)
        update!(refresh_jti: jti)
    end

    # リフレッシュトークンのJWT IDを削除する
    def forget
        update!(refresh_jti: nil)
    end


    private

        # email小文字化
        def downcase_email
            self.email.downcase! if email
        end

end
