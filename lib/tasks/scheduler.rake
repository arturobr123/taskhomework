require 'openpay'

desc "Tasks task"


#YA PROBADA :)
#las tareas que estan en el estado de espera, si no acepto ninguna propuesta, desde de 24 horas de su deadline, se eliminara.
task :check_homeworks_deadline_past => :environment do

	@time = DateTime.now + 12.hours #asi le da 12 horas antes de la fecha de entrega

  @homeworks = Homework.where("status = 1 and deadline < ?", @time)

  @homeworks.each do |homework|
		# puts homework.deadline.to_datetime
		# puts x = '%02d' % homework.deadline.to_datetime.hour #hora
		# puts @time
		# puts DateTime.now
		# puts homework.name

		@notifications = Notification.where(item_id: homework.id)

		if(@notifications)
			@notifications.destroy_all
		end

  	homework.destroy

  end

end

#YA PROBADA :) :) CON PAYPAL !! ME MANDA UN CORREO Y YO DEBO DEVOLVER EL PAGO DE MANERA MANUAL
#cuando el tasker no subido nada y ya paso la fecha de entrega, toca regresar el dinero al estudiante
task :check_classrooms_tasker_not_complete => :environment do

	time = DateTime.now - 5.hours #horas despues del deadline

  @classrooms = Classroom.joins(:proposal).where(finished: false).where("deadline < ?", time)

  @classrooms.each do |classroom|
  	puts classroom.homework.name

    @homework = Homework.find(classroom.homework_id)
    @proposal = Proposal.find(classroom.proposal_id)

    begin
			@homework.update!(status: 3)
			@proposal.update!(status: 3)
			classroom.update!(:finished => true, :finished_date => DateTime.now , :user_accepts => false)
			NotiMailer.refund_user_not_get_homework(@homework.user.email, @homework.user, @homework).deliver
    rescue Exception => e
      puts e.description
    end

  end

end



#se toma como que si le gusto al estudiante, y se procederá al pago.
task :check_classrooms => :environment do

	time = DateTime.now - 1.day

  @classrooms = Classroom.where("finished = ? and user_accepts is ? and finished_date < ?", true, nil, time)

  @classrooms.each do |classroom|
  	puts classroom.homework.name

    @homework = Homework.find(classroom.homework_id)
    @proposal = Proposal.find(classroom.proposal_id)

    begin
			#envio de correo al trabajador
			NotiMailer.send_money_to_tasker_homework_complete(@proposal.admin.email, @homework, classroom).deliver
			#enviarme correo para pasar el dinero a la cuenta del trabajador
			NotiMailer.notify_worker_accepts_homework(@proposal.admin.email, @homework, classroom).deliver

			classroom.update(user_accepts: true)
    rescue Exception => e
      puts e
    end

  end

end














#YA PROBADA :) CON PAYPAL!!    :( PERO SE QUEDARA EN PAUSA POR LOS PAYOUTS
#si ya pasaron 24 horas y el usuario no ha contestando, se tomara como que SI le gusto la tarea y se hará el cobro
# task :check_classrooms => :environment do
#
# 	time = DateTime.now + 1.day
#
#   @classrooms = Classroom.where("finished = ? and user_accepts is ? and finished_date < ?", true, nil, time)
#
#   @classrooms.each do |classroom|
#   	puts classroom.homework.name
#
#     @homework = Homework.find(classroom.homework_id)
#     @proposal = Proposal.find(classroom.proposal_id)
#
# 		price = @proposal.cost - (0.15 * @proposal.cost)
#
#     @payout = Payout.new(
#       {
#         :sender_batch_header => {
#           :sender_batch_id => SecureRandom.hex(8),
#           :email_subject => 'Pago por la tarea de: ' + @homework.name,
#         },
#         :items => [
#           {
#             :recipient_type => 'EMAIL',
#             :amount => {
#               :value => price.to_s,
#               :currency => 'MXN'
#             },
#             :note => 'Pago por la tarea de: ' + @homework.name,
#             :receiver =>  @proposal.admin.email, #proposal.admin.email
#             :sender_item_id => "8EKK43ENJJYS2", #aqui el id de la cuenta
#           }
#         ]
#       }
#     )
#
#     begin
#       @payout_batch = @payout.create
# 			puts "bieeen"
# 			#classroom.update(user_accepts: true)
#     rescue Exception => e
#       puts e
#     end
#
#   end
#
# end













task :prueba => :environment do
	puts "HOLA MUNDOO"
end
