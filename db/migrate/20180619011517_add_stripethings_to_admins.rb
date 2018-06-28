class AddStripethingsToAdmins < ActiveRecord::Migration[5.1]
  def change
  	add_column :admins, :stripe_customer_token, :string
  end
end
