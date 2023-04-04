class AddGuestFlgToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :guest_flg, :boolean, default: false, null: false
  end
end
