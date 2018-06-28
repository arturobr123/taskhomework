class Archive < ApplicationRecord

	belongs_to :homework

  has_attached_file :archivo
  #pdf, .doc , .docx
  validates_attachment_content_type :archivo,:content_type => ['application/pdf','application/msword','application/vnd.openxmlformats-officedocument.wordprocessingml.document', /\Aimage\/.*\z/]

end
