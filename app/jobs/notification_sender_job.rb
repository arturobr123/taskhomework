class NotificationSenderJob < ApplicationJob
  queue_as :default

  def perform(item)
  	#crea!! la notificacion de los usuarios
  	Notification.create(item: item, user_id: item.user_ids)
    # Do something later
  end
end
