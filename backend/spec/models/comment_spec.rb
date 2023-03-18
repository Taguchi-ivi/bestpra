# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    context 'テーブルと正しく紐づいているか' do
      it 'Userテーブル' do
        rel = described_class.reflect_on_association(:user)
        expect(rel.macro).to eq :belongs_to
      end

      it 'Articleテーブル' do
        rel = described_class.reflect_on_association(:article)
        expect(rel.macro).to eq :belongs_to
      end
    end

    context 'コメントを削除した場合' do
      it  '通知も削除される' do
        visitor = create(:user)
        visited = create(:user)
        article = create(:article)
        comment = create(:comment, user_id: visitor.id, article_id: article.id)
        notification = create(:notification, visitor_id:  visitor.id, visited_id: visited.id, article_id: article.id, comment_id: comment.id, action: 'comment')
        expect { comment.destroy }.to change { Notification.count }.by(-1)
      end
    end
  end

  describe 'correct_comment' do
    context '正しい値が入力された場合' do
      let!(:comment) { create(:comment) }
      it 'コメントが作成される' do
        expect(comment).to be_valid
      end
    end
  end

  describe 'validate_presence' do
    context 'conetentがnilだった場合' do
      it 'コメントが作成されない' do
        comment = build(:comment, content: nil)
        comment.valid?
        expect(comment).to be_invalid
      end
    end

    context 'userがnilだった場合' do
      it 'コメントが作成されない' do
        comment = build(:comment, user_id: nil)
        comment.valid?
        expect(comment).to be_invalid
      end
    end

    context 'articleがnilだった場合' do
      it 'コメントが作成されない' do
        comment = build(:comment, article_id: nil)
        comment.valid?
        expect(comment).to be_invalid
      end
    end
  end
end
