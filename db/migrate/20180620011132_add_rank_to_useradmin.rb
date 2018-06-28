class AddRankToUseradmin < ActiveRecord::Migration[5.1]
  def change
  	add_column :admins, :rank, :float, default: 5.0
  	add_column :users, :rank, :float, default: 5.0
  end
end
