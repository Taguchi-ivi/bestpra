FactoryBot.define do
    factory :level_list do
        sequence(:id) { |n| n }
        sequence(:name) { |n| "小学生#{n}" }
    end
end