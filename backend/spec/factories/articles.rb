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
FactoryBot.define do
    factory :article do
        sequence(:id) { |n| n }
        title { 'test' }
        content { 'test' }
        image { '' }
        association :user
        association :level_list
    end
end
