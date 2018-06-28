class AddReferenceToArchiveClassroom < ActiveRecord::Migration[5.1]
  def change
  	add_reference :archive_classrooms, :classroom, foreign_key: true
  end
end
