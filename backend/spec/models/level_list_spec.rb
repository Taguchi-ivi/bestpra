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
  pending "add some examples to (or delete) #{__FILE__}"
end
