FactoryBot.define do
    factory :comment do
        content { 'test' }
        association :user
        association :article
    end
end