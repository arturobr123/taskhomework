class AddTokenToUserAdmin < ActiveRecord::Migration[5.1]
  def change
  	add_column :admins, :token, :string
  	add_column :users, :token, :string

  end
end
