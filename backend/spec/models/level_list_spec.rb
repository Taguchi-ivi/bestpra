# == Schema Information
#
# Table name: level_lists
#
#  id         :bigint           not null, primary key
#  delete_flg :boolean          default(FALSE), not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe LevelList, type: :model do

  describe 'associations' do
    context 'テーブルと正しく紐づいているか' do
      it 'articleテーブル' do
        rel = described_class.reflect_on_association(:articles)
        expect(rel.macro).to eq :has_many
      end

      it 'notificationsテーブル' do
        rel = described_class.reflect_on_association(:notifications)
        expect(rel.macro).to eq :has_many
      end
    end
  end

  describe 'correct_level_list' do
    context '正しく指定されている場合' do
      let!(:level_list) { create(:level_list) }
      it 'level_listが登録される' do
        expect(level_list).to be_valid
      end
    end
  end

  describe 'validate_presence' do
    context 'nameの値が空の場合' do
      it 'level_listが作成されない' do
        level_list = build(:level_list, name: '')
        expect(level_list).to be_invalid
      end
    end
  end

  describe 'validate_uniqueness' do
    context 'nameの値が重複している場合' do
      it 'level_listが作成されない' do
        create(:level_list, name: '小学生')
        level_list = build(:level_list, name: '小学生')
        expect(level_list).to be_invalid
      end
    end
  end
end
