class User < ApplicationRecord

    # bcrypt
    # (暗号化/ passwordとして使用/ password_confirmationも使用可能)
    has_secure_password

    # avatar用 carrierwave
    mount_uploader :avatar, AvatarUploader

    # validate
    # allow_blank: true => エラー内容を何個も出力させない為の処理
    validates :nickname, presence: true,
                length: { maximum: 30, allow_blank: true }
    validates :email, presence: true, uniqueness: true
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





end
