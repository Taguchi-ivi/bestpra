# == Schema Information
#
# Table name: tag_maps
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  article_id  :bigint           not null
#  tag_list_id :bigint           not null
#
# Indexes
#
#  index_tag_maps_on_article_id                  (article_id)
#  index_tag_maps_on_tag_list_id                 (tag_list_id)
#  index_tag_maps_on_tag_list_id_and_article_id  (tag_list_id,article_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (tag_list_id => tag_lists.id)
#
FactoryBot.define do
    factory :tag_map do
        association :article
        association :tag_list
    end
end
