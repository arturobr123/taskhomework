class AddStripethingsToUser < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :stripe_customer_token, :string
  	add_column :users, :card1, :text
  end
end
