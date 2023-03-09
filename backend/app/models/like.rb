# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_likes_on_article_id  (article_id)
#  index_likes_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
class Like < ApplicationRecord

    # association
    belongs_to :user
    belongs_to :article

    # いいねの通知を作成する
    def create_notification_like!(current_user)
        return if current_user.id == self.user_id
        temp = Notification.where(["visitor_id = ? and visited_id = ? and article_id = ? and action = ? ", current_user.id, self.user_id, self.article_id, 'like'])
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
        temp = Notification.where(["visitor_id = ? and visited_id = ? and article_id = ? and action = ? ", current_user.id, self.user_id, self.article_id, 'like'])
        temp.destroy_all unless temp.blank?
    end
end
