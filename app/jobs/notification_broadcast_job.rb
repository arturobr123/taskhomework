#ESTE JOB ES EL QUE SE ENCARGA DE ENVIAR LAS NOTIFICATIONES EN TIEMPO REAL POR MEDIO DE WEB SOCKETS
class NotificationBroadcastJob < ApplicationJob
  queue_as :default
  #envia la notificaciones de los usuarios en tiempo real
  def perform(notification)

  	notification_count = Notification.for_user(notification.user_id) #cuanta cuantas notificaiones no vistas tiene el usuario contando la nueva notificacion

    ActionCable.server.broadcast "notifications.#{notification.user_id}",
    							  {action: "new_notification", message: notification_count}
  end
end
