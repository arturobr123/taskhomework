class NotificationWorker < ApplicationRecord
  belongs_to :admin
  belongs_to :item, polymorphic: true

  #scopes
  scope :unviewed, -> {where(viewed:false)}
  scope :latest, -> {order("created_at desc").limit(10)}

  #FALTA PONER BIEN EL CANAL DE LAS NOTIFICACIONES Y ACTIVAR EL JOB EN TIEMPO REAL
  #envia las notificaciones en tiempo real
  #after_create_commit {NotificationBroadcastJob.perform_later(self)}

  #cuantas notificaciones no ha visto el worker, esto usa el notificationBroadcastWorkjob para enviar ese numero cuando
  #recibe una nueva notificacion
  def self.for_admin(admin_id)
  	NotificationWorker.where(admin_id: admin_id).unviewed.count

  end

end
