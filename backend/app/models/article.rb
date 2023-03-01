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
    validates :title, presence: true,length: { maximum: 30 }
    validates :content, presence: true


    # association
    belongs_to :user
    belongs_to :level_list
    has_many :tag_maps, dependent: :destroy
end
