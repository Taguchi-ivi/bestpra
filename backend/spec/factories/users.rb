# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  activated       :boolean          default(FALSE), not null
#  admin           :boolean          default(FALSE)
#  avatar          :string(255)
#  birthday        :date
#  email           :string(255)      not null
#  guest_flg       :boolean          default(FALSE), not null
#  introduction    :text(65535)
#  nickname        :string(255)      not null
#  password_digest :string(255)      not null
#  refresh_jti     :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  basecolor_id    :integer          default(0)
#
FactoryBot.define do
    factory :user do
        sequence(:id) { |n| n }
        sequence(:nickname) { 'test_1' }
        sequence(:email) { |n| "test#{n}@example.com" }
        password { 'password' }
        activated { true }
    end
end
