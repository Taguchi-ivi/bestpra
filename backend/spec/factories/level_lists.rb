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
FactoryBot.define do
    factory :level_list do
        sequence(:id) { |n| n }
        sequence(:name) { |n| "小学生#{n}" }
    end
end
