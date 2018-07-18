#este consern hace que cuando se cree una vacante aplicada le mandará una nótifiación
#al administrador indicandole que han aplicado a una vacante
module Notificable
	extend ActiveSupport::Concern

	included do
	  has_many :notifications, as: :item, dependent: :destroy
	  #after_update_commit :send_notification_to_users_classroom

	  #cuando se crea algo que incluya este concern, se crea una notificación y se envia !!!!!!!! (importante)
	  after_create_commit :send_notification_to_users
	end

	def send_notification_to_users
		if self.respond_to? :user_ids #checa que tenga el metodo user_ids
			#JOB => mandar notificaciones asyncronas
			NotificationSenderJob.perform_later(self)
			
		end
		
	end

	
end