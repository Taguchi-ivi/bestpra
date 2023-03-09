class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :article_id
      t.integer :comment_id
      t.integer :level_list_id
      t.string :action, default: '', null: false
      t.string :content, default: ''
      t.boolean :checked, default: false, null: false
      t.boolean :admin, default: false, null: false

      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :article_id
    add_index :notifications, :comment_id
    add_index :notifications, :level_list_id
  end
end
