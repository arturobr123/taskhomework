class AddFinished3ToClassrrom < ActiveRecord::Migration[5.1]
  def change
  	add_column :classrooms, :finished, :boolean, default: false
  end
end
