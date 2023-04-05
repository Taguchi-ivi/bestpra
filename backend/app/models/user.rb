# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  activated       :boolean          default(FALSE), not null
#  admin           :boolean          default(FALSE)
#  avatar          :string(255)
#  birthday        :date
#  email           :string(255)      not null
#  guest_flg       :boolean          default(FALSE), not null
#  introduction    :text(65535)
#  nickname        :string(255)      not null
#  password_digest :string(255)      not null
#  refresh_jti     :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  basecolor_id    :integer          default(0)
#
require "validator/email_validator"

class User < ApplicationRecord
    # Token生成モジュール services/token_generate_service.rb
    include TokenGenerateService

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


    # association
    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :active_relationships, class_name: 'Relationship',
                                    foreign_key: 'follower_id',
                                    dependent: :destroy
    has_many :passive_relationships, class_name: 'Relationship',
                                    foreign_key: 'followed_id',
                                    dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
    # active_notifications：自分からの通知
    has_many :active_notifications, class_name: 'Notification',
                                    foreign_key: 'visitor_id',
                                    dependent: :destroy
    # passive_notifications：相手からの通知
    has_many :passive_notifications, class_name: 'Notification',
                                    foreign_key: 'visited_id',
                                    dependent: :destroy


    # scope
    # default_scope -> { order(created_at: :desc) }

    # ゲストユーザー作成
    def self.guest
        email = "guest#{rand(1..1000)}@guestguest.com"
        while User.exists?(email: email)
            email = "guest#{rand(1..1000)}@aaa.com"
        end
        user = User.new(
            email: email,
            password: SecureRandom.urlsafe_base64,
            nickname: "ゲストユーザー",
            activated: true,
            guest_flg: true
        )
    end

    # ユーザをフォローする
    def follow(other_user)
        following << other_user unless self == other_user
    end

    # ユーザをフォロー解除する
    def unfollow(other_user)
        # following.delete(other_user)
        active_relationships.find_by(followed_id: other_user.id).destroy
    end

    # フォローしているかどうか
    def following?(other_user)
        following.include?(other_user)
    end

    # フォローした際に通知を作成
    def create_notification_follow!(current_user)
        temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, self.id, 'follow'])
        if temp.blank?
            notification = current_user.active_notifications.new(
                visited_id: self.id,
                action: 'follow'
            )
            notification.save if notification.valid?
        end
    end

    # フォロー解除した際に通知を削除
    def delete_notification_follow!(current_user)
        temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, self.id, 'follow'])
        temp.destroy_all if temp
    end


    ## methods
    # メールのバリデーション設定(メールで検証link等の実装時に必要)
    # class method  ###########################
    class << self
        # emailからアクティブなユーザーを返す
        def find_by_activated(email)
            # find_by(email: email, activated: true)
            find_by(email: email)
        end
    end
    # class method end #########################

    # 自分以外の同じemailのアクティブなユーザーがいる場合にtrueを返す
    def email_activated?
        users = User.where.not(id: id)
        users.find_by_activated(email).present?
    end

    # リフレッシュトークンのJWT IDを記憶する
    def remember(jti)
        update!(refresh_jti: jti)
    end

    # リフレッシュトークンのJWT IDを削除する
    def forget
        update!(refresh_jti: nil)
    end

    # 共通のJSONレスポンス
    # 返却データ => onlyにavatar
    # 呼び出し元でカスタムできるようにmergeを指定 => merge(sub: "sub")とするとHashにsubが追加される
    # with_indifferent_access => Railsのメソッド => hashのキーをシンボルでも文字列でも取得できるようにする
    def response_json(payload = {})
        as_json(only: [:id, :nickname, :avatar, :admin, :introduction, :guest_flg]).merge(payload).with_indifferent_access
    end

    # 自身で書いた記事か判定
    # def has_written?(article)
    #     articles.exists?(id: article.id)
    # end


    private

        # email小文字化
        def downcase_email
            self.email.downcase! if email
        end

end
