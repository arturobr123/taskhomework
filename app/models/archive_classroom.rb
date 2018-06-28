class ArchiveClassroom < ApplicationRecord
	belongs_to :classroom

  has_attached_file :archivo
  #pdf, .doc , .docx
  validates_attachment_content_type :archivo,:content_type => ['application/vnd.ms-excel','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','application/vnd.ms-office","application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','application/vnd.openxmlformats-officedocument.presentationml.presentation','application/zip', 'application/x-zip','application/pdf','application/msword','application/vnd.openxmlformats-officedocument.wordprocessingml.document', /\Aimage\/.*\z/]

  #incluye el concern Notificable
	include Notificable
  
  #a quien enviará la notificación
  def user_ids
  	return self.classroom.user_id
  end

end
