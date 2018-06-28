class RemovetypeFromHomework < ActiveRecord::Migration[5.1]
  def change
  	remove_column :homeworks, :type, :integer

  	add_column :homeworks, :tipo, :integer
  end
end
