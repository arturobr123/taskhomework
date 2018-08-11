class Archive < ApplicationRecord

	belongs_to :homework

  has_attached_file :archivo
  #pdf, .doc , .docx
  validates_attachment_content_type :archivo,:content_type => ['text/plain','application/vnd.ms-excel','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','application/vnd.ms-office","application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','application/vnd.openxmlformats-officedocument.presentationml.presentation','application/zip', 'application/x-zip','application/pdf','application/msword','application/vnd.openxmlformats-officedocument.wordprocessingml.document', /\Aimage\/.*\z/]

end
