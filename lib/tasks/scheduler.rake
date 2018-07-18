require 'openpay'

desc "Tasks task"

task :check_homeworks_deadline_past => :environment do
  
	time = DateTime.now + 1.day

  @homeworks = Homework.where("status = 1 and  deadline < ?", time)

  @homeworks.each do |homework|
  	homework.destroy
  end
  
end


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
    rescue Exception => e
      puts e.description
    end

    classroom.update(user_accepts: true)

  end

end


task :prueba => :environment do
	puts "HOLA MUNDO"
end
