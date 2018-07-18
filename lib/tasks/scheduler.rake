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



# task :get_commisions_and_send_money => :environment do
  
#   #merchant and private key
#   merchant_id='mnn5gyble3oezlf6ca3v'
#   private_key='sk_33044f35a7364f81b7139b21327a5927'
#   openpay=OpenpayApi.new(merchant_id,private_key)

#   @trabajadores = Admin.all

#   #CUSTOMERS
#   @customers= openpay.create(:customers)
#   #COMISIONES
#   @fees = openpay.create(:fees)
#   #pagos a CLABE
#   @payouts = openpay.create(:payouts)


#   #OBTENER LAS COMISIONES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#   @trabajadores.each do |trabajador|
#     puts trabajador.name

#     if(trabajador.open_pay_user_id && trabajador.open_pay_clabe_id)

#       response_hash = @customers.get(trabajador.open_pay_user_id)

#       #puts response_hash
#       puts " !! "
#       puts " !! "
#       puts response_hash["balance"]

#       #si vemos que tiene un balance > 10, le hacemos la comision
#       #esto se hace asi porque cada 14 dias se estan haciendo las comisiones
#       #y vaciando las cuentas, por lo tanto, cada 14 dias las cuentas inician en 0
#       @total = response_hash["balance"].to_i
#       if(@total > 10)

#         comision = @total * 0.05

#         puts comision.to_s

#         new_fee_hash={
#           "customer_id" => trabajador.open_pay_user_id,
#           "amount" => comision,
#           "description" => "Cobro de Comisión"
#         }

#         begin
#           @fees.create(new_fee_hash.to_h)
#         rescue Exception => e
#           puts e.description# => 'The api key or merchant id are invalid.'
#         end

#         puts "EXITO EN COMISION!!"


#       end        

#     end

#   end

# end


task :prueba => :environment do
	puts "HOLA MUNDO"
end
