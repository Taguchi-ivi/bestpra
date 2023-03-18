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

  describe 'associations' do
    context 'テーブルと正しく紐づいているか' do
      it 'followersテーブル' do
        rel = described_class.reflect_on_association(:follower)
        expect(rel.macro).to eq :belongs_to
      end

      it 'followingテーブル' do
        rel = described_class.reflect_on_association(:followed)
        expect(rel.macro).to eq :belongs_to
      end
    end
  end

  describe 'correct_relationships' do
    context '正しい値の場合' do
      it 'relationshipを作成できる' do
        following = create(:user)
        follower = create(:user)
        relationship = build(:relationship, follower: follower, followed: following)
        relationship.save
        expect(relationship).to be_valid
      end
    end
  end

  describe 'validate_presence' do
    context 'followed_idがnilの場合' do
      let!(:relationship) { build(:relationship, follower_id: nil) }
      it 'relationshipが作成できない' do
        following = create(:user)
        relationship = build(:relationship, follower: nil, followed: following)
        relationship.save
        expect(relationship).to be_invalid
      end
    end

    context 'follower_idがnilの場合' do
      let!(:relationship) { build(:relationship, followed_id: nil) }
      it 'relationshipが作成できない' do
        follower = create(:user)
        relationship = build(:relationship, follower: follower, followed: nil)
        relationship.save
        expect(relationship).to be_invalid
      end
    end
  end

  describe "follow and unfollow a user" do
    before do
      @user_first = create(:user)
      @user_second = create(:user)
    end

    it "should follow and unfollow a user" do
      # フォローしていないことを確認
      expect(@user_first.following?(@user_second)).to be_falsey

      # フォローしてフォローできていることを確認
      @user_first.follow(@user_second)
      expect(@user_first.following?(@user_second)).to be_truthy
      expect(@user_second.followers).to include(@user_first)

      # フォローを解除して解除できていることを確認
      @user_first.unfollow(@user_second)
      expect(@user_first.following?(@user_second)).to be_falsey

      # 自分自身をフォローできないことを確認
      @user_first.follow(@user_first)
      expect(@user_first.following?(@user_first)).to be_falsey
    end
  end
end
