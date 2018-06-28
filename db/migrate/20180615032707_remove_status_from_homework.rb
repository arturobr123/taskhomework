class RemoveStatusFromHomework < ActiveRecord::Migration[5.1]
  def change
  	remove_column :homeworks, :status, :integer

  	add_column :homeworks, :status, :integer, default: 1
  end
end
