FactoryBot.define do
    factory :article do
        title { 'test' }
        content { 'test' }
        image { '' }
        association :user
        association :level_list
    end
end