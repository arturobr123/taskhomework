class AddAttachmentToArchive < ActiveRecord::Migration[5.1]
  def change
  	add_attachment :archives, :archivo
  end
end
