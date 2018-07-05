class AddLastName2ToAdmin < ActiveRecord::Migration[5.1]
  def change
  	change_column :admins, :last_name, :string, default: ""
  end
end
