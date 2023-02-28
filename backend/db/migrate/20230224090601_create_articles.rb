class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :level_list, null: false, foreign_key: true
      t.string :title, null:false
      t.string :image
      t.text :content, null:false
      t.timestamps
    end
  end
end