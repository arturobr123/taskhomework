class AddLastNameAgainToAdmin < ActiveRecord::Migration[5.1]
  def change
  	remove_column :admins, :last_name, :string
  	add_column :admins, :last_name, :string, default:""
  end
end
