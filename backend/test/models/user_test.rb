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
require "test_helper"

class UserTest < ActiveSupport::TestCase

    # helperで定義したacvive_userを使用
    def setup
        # @user = active_user
        @user_first = User.create(nickname: "test taro", email: "example@example.com", password: "password", activated: true)
        @user_second = User.create(nickname: "test jiro", email: "example2@example.com", password: "password", activated: true)
    end

    test "nickname_validation" do
        # 入力必須
        user = User.new(email: "test@example.com", password: "password")
        user.save
        required_msg = ["名前を入力してください"]
        assert_equal(required_msg, user.errors.full_messages)

        # 30文字の制限
        max = 30
        nickname = "a" * (max + 1)
        user.nickname = nickname
        user.save
        maxlength_msg = ["名前は30文字以内で入力してください"]
        assert_equal(maxlength_msg, user.errors.full_messages)

        # 30文字以内のユーザは保存できるか
        # 正しく保存されていることを確認
        nickname = "あ" * max
        user.nickname = nickname
        assert_difference("User.count", 1) do
            user.save
        end
    end

    test "email_validation" do
        # 入力必須
        user = User.new(nickname: "test", password: "password")
        user.save
        required_msg = ["メールアドレスを入力してください"]
        assert_equal(required_msg, user.errors.full_messages)

        # 255制限
        # byebug
        max = 255
        domain = "@example.com"
        email = "a" * (max + 1 - domain.length) + domain
        assert max < email.length
        user.email = email
        user.save
        maxlength_msg = ["メールアドレスは#{max}文字以内で入力してください"]
        assert_equal(maxlength_msg, user.errors.full_messages)

        # 正しい形式
        ok_emails = %w(
            A@EX.COM
            a-_@e-x.c-o_m.j_p
            a.a@ex.com
            a@e.co.js
            1.1@ex.com
            a.a+a@ex.com
        )
        ok_emails.each do |email|
            user.email = email
            assert user.save
        end

        # 間違った書式はエラーを吐くか
        ng_emails = %w(
            aaa
            a.ex.com
            メール@ex.com
            a~a@ex.com
            a@|.com
            a@ex.
            .a@ex.com
            a＠ex.com
            Ａ@ex.com
            a@?,com
            １@ex.com
            "a"@ex.com
            a@ex@co.jp
        )
        ng_emails.each do |email|
            user.email = email
            user.save
            format_msg = ["メールアドレスは不正な値です"]
            assert_equal(format_msg, user.errors.full_messages)
        end
    end

    test "email_downcase" do
        # emailが小文字化されているか
        email = "USER@EXAMPLE.COM"
        user = User.new(email: email)
        user.save
        assert user.email == email.downcase
    end


    test "active_user_uniquesess" do
        # 本来:emailの認証リンクを実施する場合
        # アクティブユーザ = activated: true

        # アクティブユーザがいない場合、同じemailが保存されるか
        # email = "test@example.com"
        # count = 3
        # assert_difference("User.count", count) do
        #     count.times do |n|
        #         User.create(nickname: "test", email: email, password: "password")
        #     end
        # end

        # アクティブユーザがいる場合、同じemailでバリデーションエラー
        # active_user = User.find_by(email: email)
        # active_user .update!(activated: true)
        # assert active_user.activated

        # assert_no_difference("User.count") do
        #     user = User.new(nickname: "test", email: email, password: "password")
        #     user.save
        #     uniqueness_message = ["メールアドレスはすでに存在します"]
        #     assert_equal(uniqueness_message, user.errors.full_messages)
        # end

        # アクティブユーザがいなくなった場合、保存できるか
        # active_user.destory!
        # assert_difference("User.count", 1) do
        #     User.create(nickname: "test", email: email, password: "password", activated: true)
        # end

        # アクティブユーザがemialの一意性は保たれているか
        email = "test@example.com"
        assert_difference("User.count", 1) do
            User.create(nickname: "test", email: email, password: "password")
        end

        user = User.new(nickname: "test", email: email, password: "password")
        user.save
        uniqueness_message = ["メールアドレスはすでに存在します"]
        assert_equal(uniqueness_message, user.errors.full_messages)

        assert_equal(1,User.where(email: email).count)

        # 上記はemailの認証リンクを実装したら、まだなので、一意性の確認と有効か確認

    end

    test "password_validation" do
        # 入力必須
        user = User.new(nickname: "test", email: "test@example.com")
        user.save
        required_msg = ["パスワードを入力してください"]
        assert_equal(required_msg, user.errors.full_messages)

        # min文字以上
        min = 8
        user.password = "a" * (min - 1)
        user.save
        minlength_msg = ["パスワードは8文字以上で入力してください"]
        assert_equal(minlength_msg, user.errors.full_messages)

        # max文字以下
        max = 72
        user.password = "a" * (max + 1)
        user.save
        maxlength_msg = ["パスワードは72文字以内で入力してください"]
        assert_equal(maxlength_msg, user.errors.full_messages)

        # 書式チェック VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
        ok_passwords = %w(
            pass---word
            ________
            12341234
            ____pass
            pass----
            PASSWORD
        )
        ok_passwords.each do |pass|
            user.password = pass
            assert user.save
        end

        ng_passwords = %w(
            pass/word
            pass.word
            |~=?+"a"
            １２３４５６７８
            ＡＢＣＤＥＦＧＨ
            password@
        )
        format_msg = ["パスワードは半角英数字・ﾊｲﾌﾝ・ｱﾝﾀﾞｰﾊﾞｰが使えます"]
        ng_passwords.each do |pass|
            user.password = pass
            user.save
            assert_equal(format_msg, user.errors.full_messages)
        end
    end

    test 'should follow and unfollow a user' do
        assert_not @user_first.following?(@user_second)
        @user_first.follow(@user_second)
        assert @user_first.following?(@user_second)
        assert @user_second.followers.include?(@user_first)
        @user_first.unfollow(@user_second)
        assert_not @user_first.following?(@user_second)
        # ユーザーは自分自身をフォローできない
        @user_first.follow(@user_first)
        assert_not @user_first.following?(@user_first)
    end

end
