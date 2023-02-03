class User < ApplicationRecord
    # avatar用 carrierwave
    mount_uploader :avatar, AvatarUploader

    # validate
    validates :nickname, presence: true
    validates :email, presence: true, uniqueness: true
    validates :uid, presence: true

end
