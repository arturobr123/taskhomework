class NotificationSenderWorkerJob < ApplicationJob
  queue_as :default

  def perform(item)
  	#crea!! la notificacion de los trabajadores
  	NotificationWorker.create(item: item, admin_id: item.admin_ids)
    # Do something later
  end
end
