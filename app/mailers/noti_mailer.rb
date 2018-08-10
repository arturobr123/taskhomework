class NotiMailer < ApplicationMailer

	default from: 'notification_task@hotmail.com'

  #Notification when user receives a proposal from a worker
  def notification_proposal(email, proposal, homework)

  	@homework = homework
  	@proposal = proposal

    mail(to: email ,subject: "Han subido una nueva propuesta a tu tarea: #{homework.name}")
  end

  #notificar al trabajador cuando alguien ha aceptado su propuesta
  def notification_accepted_homework(email, proposal, homework)

  	@homework = homework
  	@proposal = proposal

    mail(to: email ,subject: "El usuario de la tarea: #{homework.name} ha aceptado tu propuesta")
  end

  #cuando un trabajador sube un archivo al salón, notifica al usuario
  def upload_file_homework(email, classroom , homework)

    @homework = homework
    @classroom = classroom

    mail(to: email ,subject: "Han subido un archivo a tu tarea #{homework.name}")
  end

  #notificar al usuario cuando han terminado su tarea
  def notification_finished_homework(email, classroom, homework)
    @homework = homework
    @classroom = classroom

    mail(to: email ,subject: "HAN TERMINADO TU TAREA: #{homework.name}")
  end

  #cuando envian un correo de porque no están de acuerdo con una tarea
  def disagree_homework_email(comment, classroom_id , open_pay_user_id, worker_email)

    @classroom = classroom_id
    @comment = comment
    @open_pay_user_id = open_pay_user_id

    mail(to: "arturo.bravo.rovirosa@hotmail.com" ,subject: "EMERGENCIA! Alguien no estuvo de acuerdo con una tarea salon id: #{classroom_id}")
    disagree_homework_email_worker(comment, classroom_id, worker_email).deliver
  end

	#enviar el correo de porque no estuvo de acuerdo con una tarea al trabajador
	def disagree_homework_email_worker(comment, classroom_id, worker_email)
		@classroom = classroom_id
    @comment = comment

    mail(to: worker_email ,subject: "Alguien no estuvo de acuerdo con una tarea")
	end

  #notificar al trabajador cuando el estudiante ha estado de acuerdo con la tarea, y que recibirá su pago pronto
  def notify_worker_accepts_homework(email, homework ,classroom)
    @homework = homework
    @classroom = classroom

    mail(to: email ,subject: "EL ESTUDIANTE HA ESTADO DE ACUERDO CON TU TRABAJADO DE LA TAREA: #{homework.name}")
  end

  #notificar al trabajador cuando el estudiante lo calificó
  def notify_worker_score_homework(email, homework ,classroom)
    @homework = homework
    @classroom = classroom

    mail(to: email ,subject: "El estudiante ha calificado tu trabajo de la tarea: #{homework.name}")
  end

	#notificar al trabajador que ya se le hizo su pago semanal
	def pay_ready_worker(email, trabajador, pago)
		@trabajador = trabajador
		@pago = pago

		mail(to: email ,subject: "Pago semanal")
	end

	#notificar al estudiante que el trabajador no cumplió con la treaa, y que se le regresará su dinero
	def refund_user_not_get_homework(email, user, homework)
		@user = user
		@homework = homework

		mail(to: email ,subject: "Rembolso de dinero de la tarea #{homework.name}")
	end

end
