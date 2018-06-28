class AddAttachmentToArchiveClassroom < ActiveRecord::Migration[5.1]
  def change
  	add_attachment :archive_classrooms, :archivo
  end
end
