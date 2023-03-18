# == Schema Information
#
# Table name: tag_maps
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  article_id  :bigint           not null
#  tag_list_id :bigint           not null
#
# Indexes
#
#  index_tag_maps_on_article_id                  (article_id)
#  index_tag_maps_on_tag_list_id                 (tag_list_id)
#  index_tag_maps_on_tag_list_id_and_article_id  (tag_list_id,article_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (tag_list_id => tag_lists.id)
#
require 'rails_helper'

RSpec.describe TagMap, type: :model do

  describe 'associations' do
    context 'テーブルと正しく紐づいているか' do
      it 'Articleテーブル' do
        rel = described_class.reflect_on_association(:article)
        expect(rel.macro).to eq :belongs_to
      end

      it 'Tag_listテーブル' do
        rel = described_class.reflect_on_association(:tag_list)
        expect(rel.macro).to eq :belongs_to
      end
    end
  end

  describe 'correct_tag_map' do
    context '正しい値の場合' do
      let(:article) { create(:article) }
      let(:tag_list) { create(:tag_list) }
      let(:tag_map) { create(:tag_map, article: article, tag_list: tag_list) }
      it 'TagMapが正しく作成される' do
        expect(tag_map).to be_valid
      end
    end
  end

  describe 'validate_presence' do
    context 'articleがnilの場合' do
      it 'tag_mapが作成作成されない' do
        tag_map = build(:tag_map, article: nil)
        tag_map.save
        expect(tag_map).to be_invalid
      end
    end

    context 'tag_listがnilの場合' do
      it 'tag_mapが作成作成されない' do
        tag_map = build(:tag_map, tag_list: nil)
        tag_map.save
        expect(tag_map).to be_invalid
      end
    end
  end

  describe 'validate_uniquenes' do
    context 'tag_listが違う場合' do
      it 'tag_mapが作成される' do
        article = create(:article)
        tag1 = create(:tag_list)
        tag2 = create(:tag_list, name: 'tag2')
        tag3 = create(:tag_list, name: 'tag3')

        tag_map1 = build(:tag_map, article: article, tag_list: tag1)
        tag_map2 = build(:tag_map, article: article, tag_list: tag2)
        tag_map3 = build(:tag_map, article: article, tag_list: tag3)
        tag_map1.save
        expect(tag_map1).to be_valid
        tag_map2.save
        expect(tag_map2).to be_valid
        tag_map3.save
        expect(tag_map3).to be_valid
      end
    end

    context 'tag_listが同じ場合' do
      it 'tag_mapが作成されない' do
        article = create(:article)
        tag = create(:tag_list)
        tag_map = build(:tag_map, article: article, tag_list: tag)
        tag_map2 = build(:tag_map, article: article, tag_list: tag)
        tag_map.save
        expect(tag_map).to be_valid
        tag_map2.save
        expect(tag_map2).to be_invalid
      end
    end
  end
end
