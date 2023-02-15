class User < ApplicationRecord
    # avatar用 carrierwave
    mount_uploader :avatar, AvatarUploader

    # validate
    validates :nickname, presence: true
    validates :email, presence: true, uniqueness: true
    validates :uid, presence: true



    def self.find_or_create_user(user_info)
        user = User.find_by(uid:user_info[:uid])
        return user if user

        User.create!(uid: user_info[:uid], nickname: "User_#{user_nfo[:uid]}")
    end

end
