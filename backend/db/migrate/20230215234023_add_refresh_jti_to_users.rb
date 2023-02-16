class AddRefreshJtiToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :refresh_jti, :string
  end
end
