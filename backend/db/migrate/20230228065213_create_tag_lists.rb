class CreateTagLists < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_lists do |t|
      t.string :name, null: false
      t.string :delete_flg, null: false, default: false
      t.timestamps
    end
  end
end
