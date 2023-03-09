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
    validates :title, presence: true
    validates :content, presence: true


    # association
    belongs_to :user
    belongs_to :level_list
    has_many :comments, dependent: :destroy
    has_many :tag_maps, dependent: :destroy
    has_many :tag_list, through: :tag_maps
    has_many :likes, dependent: :destroy
    has_many :notifications, dependent: :destroy

    # def as_json(options = {})
    #     super(options.merge(include: [:user, :level_list, {tag_list: {only: :name}}]))
    # end

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
end
