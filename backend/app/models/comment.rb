# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord

    # validates
    validates :content, presence: true

    # associations
    belongs_to :user
    belongs_to :article
    has_many :notifications, dependent: :destroy

    # コメントの通知を作成する
    def create_notification_comment!(current_user, comment_id)
        temp_ids = Comment.select(:user_id).where(article_id: self.id).where.not(user_id: self.user_id).distinct
        temp_ids.each do |temp_id|
            save_notification_comment!(current_user, comment_id, temp_id['user_id'])
        end

        save_notification_comment!(current_user, comment_id, self.user_id) if temp_ids.blank?
    end

    def save_notification_comment!(current_user, comment_id, visited_id)
        return if visited_id == current_user.id
        notification = current_user.active_notifications.new(
            article_id: article_id,
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
