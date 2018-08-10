class AddFinishedDateToClassrooms < ActiveRecord::Migration[5.1]
  def change
    remove_column :classrooms, :finishedDate, :datetime
    add_column :classrooms, :finished_date, :datetime
  end
end
