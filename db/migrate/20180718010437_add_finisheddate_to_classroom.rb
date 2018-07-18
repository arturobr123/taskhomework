class AddFinisheddateToClassroom < ActiveRecord::Migration[5.1]
  def change
  	add_column :classrooms, :finishedDate, :datetime

  end
end
