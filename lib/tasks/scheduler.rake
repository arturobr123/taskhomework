require 'openpay'

require 'paypal-sdk-rest'
require 'securerandom'
include PayPal::SDK::REST

desc "Tasks task"

#YA PROBADA :)
#las tareas que estan en el estado de espera, si no acepto ninguna propuesta, desde de 24 horas de su deadline, se eliminara.
task :check_homeworks_deadline_past => :environment do

	time = DateTime.now - 1.day

  @homeworks = Homework.where("status = 1 and  deadline < ?", time)

  @homeworks.each do |homework|
  	homework.destroy
  end

end

#YA PROBADA :) :) CON PAYPAL !! ME MANDA UN CORREO Y YO DEBO DEVOLVER EL PAGO DE MANERA MANUAL
#cuando el tasker no subido nada y ya paso la fecha de entrega, toca regresar el dinero al estudiante
task :check_classrooms_tasker_not_complete => :environment do

	time = DateTime.now + 2.day

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

#YA PROBADA :) CON PAYPAL!!    :( PERO SE QUEDARA EN PAUSA POR LOS PAYOUTS
#si ya pasaron 24 horas y el usuario no ha contestando, se tomara como que SI le gusto la tarea y se hará el cobro
task :check_classrooms => :environment do

	time = DateTime.now + 1.day

  @classrooms = Classroom.where("finished = ? and user_accepts is ? and finished_date < ?", true, nil, time)

  @classrooms.each do |classroom|
  	puts classroom.homework.name

    @homework = Homework.find(classroom.homework_id)
    @proposal = Proposal.find(classroom.proposal_id)

		price = @proposal.cost - (0.15 * @proposal.cost)

    @payout = Payout.new(
      {
        :sender_batch_header => {
          :sender_batch_id => SecureRandom.hex(8),
          :email_subject => 'Pago por la tarea de: ' + @homework.name,
        },
        :items => [
          {
            :recipient_type => 'EMAIL',
            :amount => {
              :value => price.to_s,
              :currency => 'MXN'
            },
            :note => 'Pago por la tarea de: ' + @homework.name,
            :receiver =>  @proposal.admin.email, #proposal.admin.email
            :sender_item_id => "8EKK43ENJJYS2", #aqui el id de la cuenta
          }
        ]
      }
    )

    begin
      @payout_batch = @payout.create
			puts "bieeen"
			#classroom.update(user_accepts: true)
    rescue Exception => e
      puts e
    end

  end

end














#YA PROBADA :)
#obtenemos la comision de los trabajadores, que es el 100 y guardamos su ganancia en la bd tabla EARNINGS
task :get_commisions => :environment do

	merchant_id = 'mnn5gyble3oezlf6ca3v'
	private_key ='sk_33044f35a7364f81b7139b21327a5927'
	openpay = OpenpayApi.new(merchant_id,private_key)

  @trabajadores = Admin.where("open_pay_user_id is not ? and open_pay_clabe_id is not ?", nil,nil)

  #CUSTOMERS
  @customers= openpay.create(:customers)
  #COMISIONES
  @fees = openpay.create(:fees)

  #OBTENER LAS COMISIONES
  @trabajadores.each do |trabajador|
    puts trabajador.name + " " + trabajador.last_name

    if(trabajador.open_pay_user_id && trabajador.open_pay_clabe_id)

      response_hash = @customers.get(trabajador.open_pay_user_id)

      #saldo que tiene en su cuenta
      puts "balance: " + response_hash["balance"].to_s

      #para cada trabajador de comision le sacamos todo lo que tiene en su cuenta
      @total = response_hash["balance"].to_i
      if(@total > 0)
        @comision = @total

        new_fee_hash={
          "customer_id" => trabajador.open_pay_user_id,
          "amount" => @comision,
          "description" => "Cobro de Comisión al trabajador con id: #{trabajador.open_pay_user_id}"
        }

        begin
          @fees.create(new_fee_hash.to_h) #hacemos el cobro de comision

					#insertamos la ganancia del trabajador en la tabla earnings
					@pago_final = @comision - ((@comision * 0.08) + 2.5)
					Earning.create(admin_id: trabajador.id, money: @pago_final)

          puts "EXITO EN COMISION E INSERSION EN TABLA EARNINGS!!"
        rescue Exception => e
          puts e.description
					puts "ERROR"
        end

			else
				#si tiene de saldo 0, simplemente crea que la ganancia del trabajador fue 0
				Earning.create(admin_id: trabajador.id, money: 0)
      end

    end

  end

end

#YA PROBADA :)
#metodo para mandar el pago a cada uno de los trabajadores
task :send_money => :environment do

  merchant_id = 'mnn5gyble3oezlf6ca3v'
	private_key ='sk_33044f35a7364f81b7139b21327a5927'
	openpay = OpenpayApi.new(merchant_id,private_key)

  @trabajadores = Admin.where("open_pay_user_id is not ? and open_pay_clabe_id is not ?", nil,nil)

  #CUSTOMERS
  @customers= openpay.create(:customers)
  #pagos a CLABE
  @payouts = openpay.create(:payouts)

  #PAGAR A LOS TRABAJADORES
  @trabajadores.each do |trabajador|
    puts trabajador.name + " " + trabajador.last_name

    if(trabajador.open_pay_user_id && trabajador.open_pay_clabe_id)

			if(trabajador.earnings.length > 0)
				@last_earning = trabajador.earnings.nuevos.first.money
			else
				@last_earning = 0
			end

			#checar si su ganancia esa semana fue mayor a 0
      if(@last_earning > 0)

				puts "pago final quitando comision: #{@last_earning.to_s}"

				request_hash={
					"method" => "bank_account",
					"destination_id" => trabajador.open_pay_clabe_id,
					"amount" => @last_earning,
					"description" => "pago del trabajador con id: #{trabajador.id}"
				}

				begin
					@payouts.create(request_hash.to_hash, trabajador.open_pay_user_id)
					#enviar correo de notficacion al trabajador
					NotiMailer.pay_ready_worker(trabajador.email, trabajador, @last_earning.to_s).deliver
					puts "EXITO EN ENVIO DE DINERO!!"
				rescue Exception => e
					puts "ERROR"
					puts e.description
					puts e.json_body
				end

			end

    end

  end

end


task :prueba => :environment do
	puts "HOLA MUNDOO"
end
