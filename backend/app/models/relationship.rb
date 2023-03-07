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
class Relationship < ApplicationRecord

    # validaiton
    validates :follower_id, presence: true
    validates :followed_id, presence: true

    # active_relationship.follower => フォロワーを返す
    # active_relationship.followed => フォローしている人を返す
    # user.active_relationships.create!(followed_id: other_user.id) => userを紐付けて能動的関係を作成/登録する（失敗時にエラーを出力）
    # user.active_relationships.build(followed_id: other_user.id) => userと紐付けた新しいRelationshipオブジェクトを返す

    # asociations
    belongs_to :follower, class_name: "User"
    belongs_to :followed, class_name: "User"
end
