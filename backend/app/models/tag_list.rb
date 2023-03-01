# == Schema Information
#
# Table name: tag_lists
#
#  id         :bigint           not null, primary key
#  delete_flg :string(255)      default("0"), not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TagList < ApplicationRecord

    # validation
    validates :name, presence: true, uniqueness: true, length: { maximum: 15 }

    # association
    has_many :tag_maps, dependent: :destroy
    has_many :articles, through: :tag_maps

end
