module NotificableWorkers
	extend ActiveSupport::Concern

	included do
	  has_many :notification_workers, as: :item, dependent: :destroy

	  #cuando se crea algo que incluya este concern, se crea una notificación y se envia !!!!!!!! (importante)
	  after_create_commit :send_notification_to_admins_accepts_proposal
		#cuando el estudiante haya aceptado o denegado, o cuando el estudiante haya calificado una tarea
		before_update :send_notification_update
	end

	def send_notification_to_admins_accepts_proposal
		if self.respond_to? :admin_ids #checa que tenga el metodo admin_ids
			#JOB => mandar notificaciones asyncronas
			send_notification("accepted_proposal")
		end
	end

	def send_notification_update
		if(self.user_accepts_changed?)
			if(self.user_accepts == true)
				send_notification("accepted_homework")
			end
			if(self.user_accepts == false)
				send_notification("denied_homework")
			end
		end

		if(self.scoreTrabajador_changed?)
			send_notification("scored_homework")
		end
	end

	def send_notification(notification_type)
		NotificationSenderWorkerJob.perform_later(self, notification_type)
	end

end
