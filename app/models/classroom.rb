class Classroom < ApplicationRecord
  belongs_to :homework
  belongs_to :user
  belongs_to :admin
  belongs_to :proposal

  has_many :archive_classrooms, dependent: :destroy
  has_one :chat_room

  after_create_commit :notify_worker

  #incluye el concern Notificable
	include NotificableWorkers
  #a quien enviará la notificación
  def admin_ids
  	return self.admin.id
  end


  #solo para verificar que es un salon
  def iam_classroom
    return true
  end

  def notify_worker
    #notify by email
    NotiMailer.notification_accepted_homework(self.proposal.admin.email, self.proposal, self.homework).deliver
    #create chat room to chat between them
    ChatRoom.create(user_id: self.user_id, admin_id: self.admin_id, title: self.homework.name, classroom_id: self.id) 
  end

end
