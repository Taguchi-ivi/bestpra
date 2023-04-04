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
FactoryBot.define do
    factory :notification do
        sequence(:visitor_id) { |n| n }
        sequence(:visited_id) { |n| n + 1 }
    end
end
