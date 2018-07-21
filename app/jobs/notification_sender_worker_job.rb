class NotificationSenderWorkerJob < ApplicationJob
  queue_as :default

  def perform(item, notification_type)
  	#crea!! la notificacion de los trabajadores
  	NotificationWorker.create(item: item, admin_id: item.admin_ids, notification_type: notification_type)
    # Do something later
  end
end
