class Notification < ApplicationRecord
  #relaciones
  belongs_to :user
  belongs_to :item, polymorphic: true


  #scopes
  scope :unviewed, -> {where(viewed:false)}
  scope :latest, -> {order("created_at desc").limit(10)}

  #envia las notificaciones en tiempo real
  after_create_commit {NotificationBroadcastJob.perform_later(self)}

  #cuantas notificaciones no ha visto el usuario, esto usa el notificationBroadcastjob para enviar ese numero cuando
  #recibe una nueva notificacion
  def self.for_user(user_id)
  	Notification.where(user_id: user_id).unviewed.count

  end

end
