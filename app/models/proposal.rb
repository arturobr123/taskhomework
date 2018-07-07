class Proposal < ApplicationRecord
  belongs_to :admin
  belongs_to :homework

  #relations
  belongs_to :admin
  belongs_to :homework

  has_one :classroom

  #scopes
  scope :nuevos, ->{order("created_at desc")}

  after_create_commit :notify_user

  #incluye el concern Notificable
	include Notificable
  
  #a quien enviará la notificación
  def user_ids
  	return self.homework.user.id
  end

  #despues de crear la propuesta, se envia correo notificacion al usuario
  def notify_user
    NotiMailer.notification_proposal(self.homework.user.email, self, self.homework).deliver 
  end

  

end
