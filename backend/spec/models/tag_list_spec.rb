# == Schema Information
#
# Table name: tag_lists
#
#  id         :bigint           not null, primary key
#  delete_flg :string(255)      default("0"), not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe TagList, type: :model do

  describe 'associations' do
    context 'テーブルと正しく紐づいているか' do
      it 'TagMapテーブル' do
        rel = described_class.reflect_on_association(:tag_maps)
        expect(rel.macro).to eq :has_many
      end

      it 'Articleテーブル' do
        rel = described_class.reflect_on_association(:articles)
        expect(rel.macro).to eq :has_many
      end
    end
  end

  describe 'correct_tag_list' do
    context '正しい値の場合' do
      it 'tag_listが作成できる' do
        tag_list = build(:tag_list)
        tag_list.save
        expect(tag_list).to be_valid
      end
    end
  end

  describe 'validate_presence' do
    context 'nameがnilの場合' do
      it 'tag_listが作成できない' do
        tag_list = build(:tag_list, name: nil)
        tag_list.save
        expect(tag_list).to be_invalid
      end
    end
  end

  describe 'validate_uniqueness' do
    context 'nameが重複している場合' do
      it 'tag_listが作成できない' do
        tag_list = create(:tag_list)
        tag_list2 = build(:tag_list, name: tag_list.name)
        tag_list2.save
        expect(tag_list2).to be_invalid
      end
    end
  end

  describe 'validate_length' do
    context 'nameが15文字の場合' do
      it 'tag_listが作成できる' do
        tag_list = build(:tag_list, name: 'a' * 15)
        tag_list.save
        expect(tag_list).to be_valid
      end
    end

    context 'nameが16文字以上の場合' do
      it 'tag_listが作成できない' do
        tag_list = build(:tag_list, name: 'a' * 16)
        tag_list.save
        expect(tag_list).to be_invalid
      end
    end
  end
end
