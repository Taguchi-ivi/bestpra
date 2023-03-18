FactoryBot.define do
    factory :user do
        sequence(:id) { |n| n }
        sequence(:nickname) { 'test_1' }
        sequence(:email) { |n| "test#{n}@example.com" }
        password { 'password' }
        activated { true }
    end
end