class NotiMailer < ApplicationMailer


	default from: 'notification_task@hotmail.com'

  #Notification when user receives a proposal from a worker
  def notification_proposal(email, proposal, homework)

  	@vacante = vacante
  	@chain_vacante = chain_vacante

    mail(to: email ,subject: "Han subido una nueva propuesta a tu tarea: #{homework.name}")
  end


end
