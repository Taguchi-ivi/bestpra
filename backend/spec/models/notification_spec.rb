# == Schema Information
#
# Table name: notifications
#
#  id            :bigint           not null, primary key
#  action        :string(255)      default(""), not null
#  admin         :boolean          default(FALSE), not null
#  checked       :boolean          default(FALSE), not null
#  content       :string(255)      default("")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  article_id    :integer
#  comment_id    :integer
#  level_list_id :integer
#  visited_id    :integer          not null
#  visitor_id    :integer          not null
#
# Indexes
#
#  index_notifications_on_article_id     (article_id)
#  index_notifications_on_comment_id     (comment_id)
#  index_notifications_on_level_list_id  (level_list_id)
#  index_notifications_on_visited_id     (visited_id)
#  index_notifications_on_visitor_id     (visitor_id)
#
require 'rails_helper'

RSpec.describe Notification, type: :model do

  describe 'associations' do
    context 'テーブルと正しく紐づいているか' do
      it 'articleテーブル' do
        rel = described_class.reflect_on_association(:article)
        expect(rel.macro).to eq :belongs_to
      end

      it 'commentテーブル' do
        rel = described_class.reflect_on_association(:comment)
        expect(rel.macro).to eq :belongs_to
      end

      it 'level_listテーブル' do
        rel = described_class.reflect_on_association(:level_list)
        expect(rel.macro).to eq :belongs_to
      end

      it 'visitedテーブル' do
        rel = described_class.reflect_on_association(:visited)
        expect(rel.macro).to eq :belongs_to
      end

      it 'visitorテーブル' do
        rel = described_class.reflect_on_association(:visitor)
        expect(rel.macro).to eq :belongs_to
      end
    end
  end

  describe 'correct_notification' do
    context '正しい値の場合' do
      it 'notificationが作成されること' do
        notification = build(:notification, action: 'like')
        expect(notification).to be_valid
      end
    end
  end

  describe 'validate_presence' do
    context 'visitorが存在しない場合' do
      it 'notificationが作成されないこと' do
        notification = build(:notification, visitor_id: nil, action: 'like')
        expect(notification).not_to be_valid
      end
    end

    context 'visitedが存在しない場合' do
      it 'notificationが作成されないこと' do
        notification = build(:notification, visited_id: nil, action: 'like')
        expect(notification).not_to be_valid
      end
    end
  end


end
