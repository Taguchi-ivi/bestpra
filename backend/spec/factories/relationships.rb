FactoryBot.define do
    factory :relationship do
        sequence(:followed_id) { |n| n }
        sequence(:follower_id) { |n| n + 1 }
    end
end