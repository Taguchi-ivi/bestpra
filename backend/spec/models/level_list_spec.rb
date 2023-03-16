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
end
