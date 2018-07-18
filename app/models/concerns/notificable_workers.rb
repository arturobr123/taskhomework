module NotificableWorkers
	extend ActiveSupport::Concern

	included do
	  has_many :notification_workers, as: :item, dependent: :destroy

	  #cuando se crea algo que incluya este concern, se crea una notificación y se envia !!!!!!!! (importante)
	  after_create_commit :send_notification_to_admins
	end

	def send_notification_to_admins
		if self.respond_to? :admin_ids #checa que tenga el metodo admin_ids
			#JOB => mandar notificaciones asyncronas
			NotificationSenderWorkerJob.perform_later(self)
			
		end
		
	end
	
end