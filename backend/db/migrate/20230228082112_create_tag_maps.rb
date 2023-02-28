class CreateTagMaps < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_maps do |t|
      t.references :article, null: false, foreign_key: true
      t.references :tag_list, null: false, foreign_key: true
      t.timestamps
    end
    add_index :tag_maps, [:tag_list_id, :article_id], unique: true
  end
end