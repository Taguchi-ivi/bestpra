# == Schema Information
#
# Table name: articles
#
#  id            :bigint           not null, primary key
#  content       :text(65535)      not null
#  image         :string(255)
#  title         :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  level_list_id :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_articles_on_level_list_id  (level_list_id)
#  index_articles_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (level_list_id => level_lists.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Article, type: :model do

  describe 'associations' do
    context 'テーブルと正しく紐づいているか' do
      it 'Userテーブル' do
        rel = described_class.reflect_on_association(:user)
        expect(rel.macro).to eq :belongs_to
      end

      it 'Level_listテーブル' do
        rel = described_class.reflect_on_association(:level_list)
        expect(rel.macro).to eq :belongs_to
      end

      it 'Tagテーブル' do
        rel = described_class.reflect_on_association(:tag_list)
        expect(rel.macro).to eq :has_many
      end

      it 'Commentテーブル' do
        rel = described_class.reflect_on_association(:comments)
        expect(rel.macro).to eq :has_many
      end

      it 'Likeテーブル' do
        rel = described_class.reflect_on_association(:likes)
        expect(rel.macro).to eq :has_many
      end

      it 'Notificationテーブル' do
        rel = described_class.reflect_on_association(:notifications)
        expect(rel.macro).to eq :has_many
      end
    end

    context '投稿を削除した場合' do
      it 'コメントも削除される' do
        user = create(:user)
        article = create(:article, user: user)
        comment = create(:comment, user: user, article: article)
        expect { article.destroy }.to change { Comment.count }.by(-1)
      end

      it 'いいねも削除される' do
        user = create(:user)
        article = create(:article, user: user)
        like = create(:like, user: user, article: article)
        expect { article.destroy }.to change { Like.count }.by(-1)
      end

      it '通知も削除される' do
        visitor = create(:user)
        visited = create(:user)
        article = create(:article, user: visited)
        like = create(:like, user: visitor, article: article)
        notification = create(:notification, visitor_id: visitor.id, visited_id: visited.id, article_id: article.id, action: 'like')
        expect { article.destroy }.to change { Notification.count }.by(-1)
      end

      it 'タグマップも削除される' do
        user = create(:user)
        article = create(:article, user: user)
        tag_list = create(:tag_list)
        tag_map = create(:tag_map, tag_list_id: tag_list.id, article_id: article.id)
        expect { article.destroy }.to change { TagMap.count }.by(-1)
      end
    end
  end

  describe 'correct_article' do
    context 'タイトルと内容とlevel_listが存在する場合' do
      let!(:article) { build(:article) }

      it '記事が作成できる' do
        # user = FactoryBot.create(:user)
        expect(article).to be_valid
      end
    end
  end

  describe 'validate_length' do
    context 'titleが80文字の場合' do
      let!(:article) { build(:article, title: 'a' * 80) }
      it '記事が作成できる' do
        expect(article).to be_valid
      end
    end

    context 'titleが81文字以上の場合' do
      let!(:article) { build(:article, title: 'a' * 81) }
      it '記事が作成できない' do
        expect(article).to be_invalid
      end
    end
  end

  describe 'validate_presence' do
    context 'タイトルがnullの場合' do
      let!(:article) { build(:article, title: nil) }
      it '記事が作成できない' do
        article.save
        expect(article).to be_invalid
      end
    end

    context 'contentがnullの場合' do
      let!(:article) { build(:article, content: nil) }
      it '記事が作成できない' do
        article.save
        expect(article).to be_invalid
      end
    end

    context 'level_list_idがnullの場合' do
      let!(:article) { build(:article, level_list_id: nil) }
      it '記事が作成できない' do
        article.save
        expect(article).to be_invalid
      end
    end
  end
end
