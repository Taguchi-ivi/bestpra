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