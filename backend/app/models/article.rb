# == Schema Information
#
# Table name: articles
#
#  id            :bigint           not null, primary key
#  content       :text(65535)      not null
#  image         :string(255)
#  title         :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  level_list_id :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_articles_on_level_list_id  (level_list_id)
#  index_articles_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (level_list_id => level_lists.id)
#  fk_rails_...  (user_id => users.id)
#
class Article < ApplicationRecord

    # image用 carrierwave
    mount_uploader :image, ImageUploader

    # validates
    validates :title, presence: true, length: { maximum: 80 }
    validates :content, presence: true


    # association
    belongs_to :user
    belongs_to :level_list
    has_many :comments, dependent: :destroy
    has_many :tag_maps, dependent: :destroy
    has_many :tag_list, through: :tag_maps
    has_many :likes, dependent: :destroy
    has_many :notifications, dependent: :destroy

    # scope
    default_scope -> { order(created_at: :desc) }
    # def as_json(options = {})
    #     super(options.merge(include: [:user, :level_list, {tag_list: {only: :name}}]))
    # end

    # xss対策
    def sanitize_content
        # self.content = Sanitize.clean(self.content, Sanitize::Config::RELAXED)
        # self.content = sanitize self.content, tags: %w(strong em u p h1 h2 h3 h4 h5 ul ol li a blockquote), attributes: %w(href)
        self.content = Sanitize.clean(self.content, Sanitize::Config::CUSTOM)
    end

    # 一度tag_mapの情報を削除する
    def delete_tag_map
        return unless TagMap.exists?(article_id: self.id)
        TagMap.where(article_id: self.id).destroy_all
    end

    def save_tags(tag_list)
        tag_list.each do |tag_name|
            next if tag_name.empty?
            tag = TagList.find_or_create_by(name: tag_name)
            self.tag_list << tag
        end
    end

    # いいねの通知を作成する
    def create_notification_like!(current_user)
        return if current_user.id == self.user_id
        temp = Notification.where(["visitor_id = ? and visited_id = ? and article_id = ? and action = ? ", current_user.id, self.user_id, self.id, 'like'])
        if temp.blank?
            notification = current_user.active_notifications.new(
                article_id: self.id,
                visited_id: self.user_id,
                action: 'like'
            )
            notification.save if notification.valid?
        end
    end

    # いいねの通知を解除
    def delete_notification_like!(current_user)
        temp = Notification.where(["visitor_id = ? and visited_id = ? and article_id = ? and action = ? ", current_user.id, self.user_id, self.id, 'like'])
        temp.destroy_all unless temp.blank?
    end

    # コメントの通知を作成する
    def create_notification_comment!(current_user, comment_id)
        temp_ids = Comment.select(:user_id).where(article_id: self.id).where.not(user_id: current_user.id).distinct
        temp_ids.each do |temp_id|
            save_notification_comment!(current_user, comment_id, temp_id['user_id'])
        end

        save_notification_comment!(current_user, comment_id, self.user_id) if temp_ids.blank?
    end

    def save_notification_comment!(current_user, comment_id, visited_id)
        return if visited_id == current_user.id
        notification = current_user.active_notifications.new(
            article_id: self.id,
            comment_id: comment_id,
            visited_id: visited_id,
            action: 'comment'
        )
        notification.save if notification.valid?
    end

    def delete_notification_comment!(current_user, comment_id)
        temps = Notification.where(["visitor_id = ? and comment_id = ? and action = ? ", current_user.id, comment_id, 'comment'])
        temps.destroy_all if temps
        # temps.each do |temp|
        #     temp.destroy
        # end
    end


end
