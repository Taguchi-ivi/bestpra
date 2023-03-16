FactoryBot.define do
    factory :like do
        association :user
        association :article
    end
end