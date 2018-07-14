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

  def notification_finished_homework(email, classroom, homework)
    @homework = homework
    @classroom = classroom

    mail(to: email ,subject: "HAN TERMINADO TU TAREA: #{homework.name}")
  end

  def disagree_homework_email(comment, classroom_id , open_pay_user_id)
    
    @classroom = classroom_id
    @comment = comment
    @open_pay_user_id = open_pay_user_id

    mail(to: "arturo.bravo.rovirosa@hotmail.com" ,subject: "EMERGENCIA! Alguien no estuvo de acuerdo con una tarea salon id: #{classroom_id}")
  end

end





