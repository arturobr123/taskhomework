require 'openpay'

desc "Tasks task"

task :check_homeworks_deadline_past => :environment do

	time = DateTime.now + 1.day

  @homeworks = Homework.where("status = 1 and  deadline < ?", time)

  @homeworks.each do |homework|
  	homework.destroy
  end

end

#si ya pasaron 48 horas y el usuario no ha contestando, se tomara como que si le gusto la tare y se hará el cobro
task :check_classrooms => :environment do

	time = DateTime.now - 2.days

  @classrooms = Classroom.where("finished = ? and user_accepts = ? and finishedDate < ?", true, nil, time)

  merchant_id = 'mnn5gyble3oezlf6ca3v'
	private_key ='sk_33044f35a7364f81b7139b21327a5927'
	@openpay = OpenpayApi.new(merchant_id,private_key)
	@transfers = @openpay.create(:transfers)

  @classrooms.each do |classroom|
  	puts classroom

  	#ahora la tarea cambia su status a finalizada
    @homework = Homework.find(classroom.homework_id)
    #ahora la propuesta cambia su status a finalizada
    @proposal = Proposal.find(classroom.proposal_id)

    new_transaction_hash={
	     "customer_id" => @proposal.admin.open_pay_user_id,
	     "amount" => @proposal.cost,
	     "description" => "Transferencia entre cuentas tarea #{@homework.id}"
	   }

    begin
      @transfers.create(new_transaction_hash.to_h, @homework.user.open_pay_user_id) #de aqui se sacara el dinero
      classroom.update(user_accepts: true)
    rescue Exception => e
      puts e.description
    end

  end

end



task :get_commisions_and_send_money => :environment do

  merchant_id = 'mnn5gyble3oezlf6ca3v'
	private_key ='sk_33044f35a7364f81b7139b21327a5927'
	openpay = OpenpayApi.new(merchant_id,private_key)

  @trabajadores = Admin.where("open_pay_user_id not ? and open_pay_clabe_id not ?", nil,nil)

  #CUSTOMERS
  @customers= openpay.create(:customers)
  #COMISIONES
  @fees = openpay.create(:fees)
  #pagos a CLABE
  @payouts = openpay.create(:payouts)


  #OBTENER LAS COMISIONES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  @trabajadores.each do |trabajador|
    puts trabajador.name
    puts trabajador.last_name

    if(trabajador.open_pay_user_id && trabajador.open_pay_clabe_id)

      response_hash = @customers.get(trabajador.open_pay_user_id)

      #saldo que tiene en su cuenta
      puts "balance: " + response_hash["balance"]

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
          @fees.create(new_fee_hash.to_h)
          puts "EXITO EN COMISION!!"
        rescue Exception => e
          puts e.description
        end

        #ahora para cada trabajador a su saldo que tenia le quitamos el %5 porciento
        #y lo demas se lo depositamos a su cuenta CLABE
        @pago_final = @comision - (@comision * 0.05)
        puts "pago final quitando comision: #{@pago_final.to_s}"

        request_hash={
          "method" => "bank_account",
          "destination_id" => trabajador.open_pay_clabe_id,
          "amount" => @pago_final,
          "description" => "pago del trabajador con id: #{trabajador.id}"
        }

        begin
          @payouts.create(request_hash.to_hash, trabajador.open_pay_user_id)
          puts "EXITO EN ENVIO DE DINERO!!"
        rescue Exception => e
          puts e.description
          puts e.json_body
        end

      end

    end

  end

end


task :prueba => :environment do
	puts "HOLA MUNDO"
end
