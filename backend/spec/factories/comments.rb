FactoryBot.define do
    factory :comment do
        content { 'test' }
        association :user
    end
end