class NotiMailer < ApplicationMailer

	default from: 'notification_task@hotmail.com'

  #Notification when user receives a proposal from a worker
  def notification_proposal(email, proposal, homework)

  	@homework = homework
  	@proposal = proposal

    mail(to: email ,subject: "Han subido una nueva propuesta a tu tarea: #{homework.name}")
  end

  #
  def notification_accepted_homework(email, proposal, homework)

  	@homework = homework
  	@proposal = proposal

    mail(to: email ,subject: "El usuario de la tarea: #{homework.name} ha aceptado tu propuesta")
  end

  def upload_file_homework(email, classroom , homework)

    @homework = homework
    @classroom = classroom

    mail(to: email ,subject: "Han subido un archivo a tu tarea #{homework.name}")
  end

end
