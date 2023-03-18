FactoryBot.define do
    factory :notification do
        sequence(:visitor_id) { |n| n }
        sequence(:visited_id) { |n| n + 1 }
    end
end