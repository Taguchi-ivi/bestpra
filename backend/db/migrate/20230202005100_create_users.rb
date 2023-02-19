class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|

      t.string :nickname, null:false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :avatar
      t.text :introduction
      t.date :birthday
      t.integer :basecolor_id, default: 0
      t.boolean :activated, null: false, default: false
      t.boolean :admin, default: false
      t.timestamps

    end
  end
end
