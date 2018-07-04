class AddOpenToAdminUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :admins, :card_id, :string
  	add_column :admins, :open_pay_user_id, :string
  	add_column :users, :card_id, :string
  	add_column :users, :open_pay_user_id, :string
  end
end
