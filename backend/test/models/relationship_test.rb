require "test_helper"

class RelationshipTest < ActiveSupport::TestCase

    # helperで定義したacvive_userを使用
    def setup
        # @user = active_user
        @user_first = User.create(nickname: "test taro", email: "example@example.com", password: "password", activated: true)
        @user_second = User.create(nickname: "test jiro", email: "example2@example.com", password: "password", activated: true)
        @relationship = Relationship.new(follower_id: @user_first.id, followed_id: @user_second.id)
    end

    test "should be valid" do
        assert @relationship.valid?
    end

    test "should require a follower_id" do
        @relationship.follower_id = nil
        assert_not @relationship.valid?
    end

    test "should require a followed_id" do
        @relationship.followed_id = nil
        assert_not @relationship.valid?
    end

end
