class NotificationBroadcastWorkerJob < ApplicationJob
  queue_as :default
  #envia la notificaciones de los trabajadores en tiempo real
  def perform(notification)

  	notification_count = NotificationWorker.for_admin(notification.admin_id) #cuanta cuantas notificaiones no vistas tiene el usuario contando la nueva notificacion

    ActionCable.server.broadcast "notificationsWorker.#{notification.admin_id}",
    							  {action: "new_notification", message: notification_count}
  end
end
