class NotiMailer < ApplicationMailer

	default from: 'notification_task@hotmail.com'

  #Notification when user receives a proposal from a worker
  def notification_proposal(email, proposal, homework)

  	@homework = homework
  	@proposal = proposal

    mail(to: email ,subject: "Han subido una nueva propuesta a tu tarea: #{homework.name}")
  end

end
