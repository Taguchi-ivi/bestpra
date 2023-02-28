class CreateLevelLists < ActiveRecord::Migration[7.0]
  def change
    create_table :level_lists do |t|
      t.string :name, null:false
      t.boolean :delete_flg, null: false, default: false
      t.timestamps
    end
  end
end