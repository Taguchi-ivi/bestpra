# == Schema Information
#
# Table name: notifications
#
#  id            :bigint           not null, primary key
#  action        :string(255)      default(""), not null
#  admin         :boolean          default(FALSE), not null
#  checked       :boolean          default(FALSE), not null
#  content       :string(255)      default("")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  article_id    :integer
#  comment_id    :integer
#  level_list_id :integer
#  visited_id    :integer          not null
#  visitor_id    :integer          not null
#
# Indexes
#
#  index_notifications_on_article_id     (article_id)
#  index_notifications_on_comment_id     (comment_id)
#  index_notifications_on_level_list_id  (level_list_id)
#  index_notifications_on_visited_id     (visited_id)
#  index_notifications_on_visitor_id     (visitor_id)
#
class Notification < ApplicationRecord

    # scope
    default_scope -> { order(created_at: :desc) }

    # validates
    validates :visitor_id, presence: true
    validates :visited_id, presence: true
    # validates :checked, presence: true
    # validates :admin, presence: true

    # associations
    belongs_to :article, optional: true
    belongs_to :comment, optional: true
    belongs_to :level_list, optional: true
    belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
    belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

end
