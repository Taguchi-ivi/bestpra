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
require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'associations' do
    context 'テーブルと正しく紐づいているか' do
      it 'followersテーブル' do
        rel = described_class.reflect_on_association(:followers)
        expect(rel.macro).to eq :has_many
      end

      it 'followingテーブル' do
        rel = described_class.reflect_on_association(:following)
        expect(rel.macro).to eq :has_many
      end

      it 'articleテーブル' do
        rel = described_class.reflect_on_association(:articles)
        expect(rel.macro).to eq :has_many
      end

      it 'commentテーブル' do
        rel = described_class.reflect_on_association(:comments)
        expect(rel.macro).to eq :has_many
      end

      it 'likeテーブル' do
        rel = described_class.reflect_on_association(:likes)
        expect(rel.macro).to eq :has_many
      end

      it 'active_notificationsテーブル' do
        rel = described_class.reflect_on_association(:active_notifications)
        expect(rel.macro).to eq :has_many
      end

      it 'passive_notificationsテーブル' do
        rel = described_class.reflect_on_association(:passive_notifications)
        expect(rel.macro).to eq :has_many
      end
    end

    context '投稿を削除した場合' do
      it 'フォロー関係も削除される' do
        following = create(:user)
        follower = create(:user)
        relationship = create(:relationship, follower: follower, followed: following)
        expect { following.destroy }.to change { Relationship.count }.by(-1)
      end

      it 'フォロワー関係も削除される' do
        following = create(:user)
        follower = create(:user)
        relationship = create(:relationship, follower: follower, followed: following)
        expect { follower.destroy }.to change { Relationship.count }.by(-1)
      end

      it '記事も削除される' do
        user = create(:user)
        article = create(:article, user: user)
        expect { user.destroy }.to change { Article.count }.by(-1)
      end

      it 'コメントも削除される' do
        user = create(:user)
        article = create(:article, user: user)
        comment = create(:comment, user: user, article: article)
        expect { user.destroy }.to change { Comment.count }.by(-1)
      end

      it 'いいねも削除される' do
        user = create(:user)
        article = create(:article, user: user)
        like = create(:like, user: user, article: article)
        expect { user.destroy }.to change { Like.count }.by(-1)
      end

      it '送った通知も削除される' do
        visitor = create(:user)
        visited = create(:user)
        article = create(:article, user: visited)
        like = create(:like, user: visitor, article: article)
        notifications = create(:notification, visitor_id: visitor.id, visited_id: visited.id, article_id: article.id, action: 'like')
        expect { visitor.destroy }.to change { Notification.count }.by(-1)
      end

      it 'もらった通知も削除される' do
        visitor = create(:user)
        visited = create(:user)
        article = create(:article, user: visited)
        like = create(:like, user: visitor, article: article)
        notification = create(:notification, visitor_id: visitor.id, visited_id: visited.id, article_id: article.id, action: 'like')
        expect { visited.destroy }.to change { Notification.count }.by(-1)
      end

    end
  end

  describe 'correct_user' do
    context '正しく指定されている場合' do
      let!(:user) { create(:user) }
      it 'ユーザーが登録される' do
        expect(user).to be_valid
      end
    end
  end

  describe 'validate_lenght' do
    context 'nicknameが30文字の場合' do
      it 'ユーザーが作成できる' do
        user = build(:user, nickname: 'a' * 30)
        user.valid?
        expect(user).to be_valid
      end
    end

    context 'nicknameが30文字を超えている場合' do
      it 'ユーザーが作成できない' do
        user = build(:user, nickname: 'a' * 31)
        user.valid?
        expect(user).to be_invalid
      end
    end

    context 'emailが255文字の場合' do
      it 'ユーザーが作成できる' do
        max = 255
        domain = '@example.com'
        email = 'a' * (max - domain.length) + domain
        user = build(:user, email: email)
        user.valid?
        expect(user).to be_valid
      end
    end

    context 'emailが255文字を超えている場合' do
      it 'ユーザーが作成できない' do
        max = 255
        domain = '@example.com'
        email = 'a' * (max + 1 - domain.length) + domain
        user = build(:user, email: email)
        user.valid?
        expect(user).to be_invalid
      end
    end

    context 'passwordが8文字の場合' do
      it 'ユーザーが作成できる' do
        user = build(:user, password: 'a' * 8)
        user.valid?
        expect(user).to be_valid
      end
    end

    context 'passwordが7文字以下の場合' do
      it 'ユーザーが作成できない' do
        user = build(:user, password: 'a' * 7)
        user.valid?
        expect(user).to be_invalid
      end
    end

    context 'passwordが73文字以上の場合' do
      it 'ユーザーが作成できない' do
        user = build(:user, password: 'a' * 73)
        user.valid?
        expect(user).to be_invalid
      end
    end
  end


  describe 'validate_presence' do
    context 'nicknameがnilの場合' do
      it 'ユーザーが作成できない' do
        user = build(:user, nickname: nil)
        user.valid?
        expect(user).to be_invalid
      end
    end

    context 'emailがnilの場合' do
      it 'ユーザーが作成できない' do
        user = build(:user, email: nil)
        user.valid?
        expect(user).to be_invalid
      end
    end

    context 'passwordがnilの場合' do
      it 'ユーザーが作成できない' do
        user = build(:user, password: nil)
        user.valid?
        expect(user).to be_invalid
      end
    end
  end

  describe 'validate_uniqueness' do
    context 'emailが重複している場合' do
      let!(:user1) { create(:user) }
      it 'ユーザーが作成できない' do
        user2 = build(:user, email: user1.email)
        user2.valid?
        expect(user2).to be_invalid
      end
    end
  end

  describe 'validate_format' do
    context 'emailの形式が正しく指定されている場合' do
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
        it "ユーザーが作成できる ->#{email}" do
          user = build(:user, email: email)
          user.valid?
          expect(user).to be_valid
        end
      end
    end

    context 'emailの形式が正しくない場合' do
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
        it "ユーザーが作成できない ->#{email}" do
          user = build(:user, email: 'test@example')
          user.valid?
          expect(user).to be_invalid
        end
      end
    end

    context 'emailが大文字の場合' do
      it '小文字に変換されてユーザーが作成できる' do
        email = 'USER@EXAMPLE.COM'
        user = build(:user, email: email)
        user.save
        expect(user.email).to eq email.downcase
      end
    end

    context 'passwordの形式が正しい場合' do
      ok_passwords = %w(
        pass---word
        ________
        12341234
        ____pass
        pass----
        PASSWORD
      )
      ok_passwords.each do |password|
        it "ユーザーが作成できる ->#{password}" do
          user = build(:user, password: password)
          user.valid?
          expect(user).to be_valid
        end
      end
    end

    context 'passowrdの形式が正しくない場合' do
      ng_passwords = %w(
          pass/word
          pass.word
          |~=?+"a"
          １２３４５６７８
          ＡＢＣＤＥＦＧＨ
          password@
      )
      ng_passwords.each do |password|
        it "ユーザーが作成できない ->#{password}" do
          user = build(:user, password: password)
          user.valid?
          expect(user).to be_invalid
        end
      end
    end
  end
end
