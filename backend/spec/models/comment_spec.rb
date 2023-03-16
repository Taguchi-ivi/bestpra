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
      it "Userテーブル" do
        rel = described_class.reflect_on_association(:user)
        expect(rel.macro).to eq :belongs_to
      end

      it "Articleテーブル" do
        rel = described_class.reflect_on_association(:article)
        expect(rel.macro).to eq :belongs_to
      end
    end

    context 'コメントを削除した場合' do
      it  "Notificationテーブル" do

    end
  end

  
end
