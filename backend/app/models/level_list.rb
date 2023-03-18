# == Schema Information
#
# Table name: level_lists
#
#  id         :bigint           not null, primary key
#  delete_flg :boolean          default(FALSE), not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class LevelList < ApplicationRecord

    validates :name, presence: true, uniqueness: true

    has_many :articles
    has_many :notifications, dependent: :destroy
end
