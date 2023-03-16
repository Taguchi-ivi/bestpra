# == Schema Information
#
# Table name: relationships
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer
#  follower_id :integer
#
# Indexes
#
#  index_relationships_on_followed_id                  (followed_id)
#  index_relationships_on_follower_id                  (follower_id)
#  index_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
require 'rails_helper'

RSpec.describe Relationship, type: :model do

  # test 'should follow and unfollow a user' do
  #   assert_not @user_first.following?(@user_second)
  #   @user_first.follow(@user_second)
  #   assert @user_first.following?(@user_second)
  #   assert @user_second.followers.include?(@user_first)
  #   @user_first.unfollow(@user_second)
  #   assert_not @user_first.following?(@user_second)
  #   # ユーザーは自分自身をフォローできない
  #   @user_first.follow(@user_first)
  #   assert_not @user_first.following?(@user_first)
  # end
end
