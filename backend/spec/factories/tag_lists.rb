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
FactoryBot.define do
    factory :tag_list do
        name {'シュート'}
    end
end
