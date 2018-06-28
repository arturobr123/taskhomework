module NotificationsHelper
	#este helper es para que: cada notificaciones tiene una columna polimorfica, donde puede
	#ser vacante aplicada, evaluation hiring manager ,etc.
	#asi que para poder mostrar cada una de diferente manera, se creo este helper,
	#recibe todas las notificaciones del administrador, y para cada una
	#va a hacer un render de un parcial, dependiendo de la columna polimorfica (item),
	#asi que checa el item_type, lo pasa a minusculas y busca ese parcial en la carpeta
	#de notificacions en views
	def render_notifications (notifications)
		notifications.map do |notification|
			render partial: "notifications/#{notification.item_type.downcase}", locals:{notification: notification}
		end.join("").html_safe
		
	end

	def render_notifications_worker (notifications)
		notifications.map do |notification|
			render partial: "notificationsworker/#{notification.item_type.downcase}", locals:{notification: notification}
		end.join("").html_safe
		
	end
end
