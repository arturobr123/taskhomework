class AddClassroomToChatroom < ActiveRecord::Migration[5.1]
  def change
  	add_reference :chat_rooms, :classroom, foreign_key: true
  end
end
