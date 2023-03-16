# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_likes_on_article_id  (article_id)
#  index_likes_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Like, type: :model do

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
  end

  describe 'correct_like' do
    context '正しい値の場合' do
      it 'likeが作成されること' do
        user = create(:user)
        article = create(:article)
        like = create(:like, user: user, article: article)
        expect(like).to be_valid
      end
    end
  end

  describe 'validate_presence' do
    context 'userが存在しない場合' do
      let!(:article) { create(:article) }
      let!(:like) { build(:like, user: nil, article: article) }
      it 'likeが作成されないこと' do
        like.save
        expect(like).to be_invalid
      end
    end

    context 'articleが存在しない場合' do
      let!(:user) { create(:user) }
      let!(:like) { build(:like, user: user, article: nil) }
      it 'likeが作成されないこと' do
        like.save
        expect(like).to be_invalid
      end
    end
  end

end
