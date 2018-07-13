class AddCuentaBancarioToAdmin < ActiveRecord::Migration[5.1]
  def change
  	add_column :admins, :open_pay_clabe_id, :string
  	add_column :admins, :phrase, :text
  end
end
