class AddScoreToClassroom < ActiveRecord::Migration[5.1]
  def change
  	add_column :classrooms, :scoreTrabajador, :integer
  end
end
