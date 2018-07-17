desc "Tasks task"

task :check_homeworks_deadline_past => :environment do
  
	time = DateTime.now + 1.day

  @homeworks = Homework.where("status = 1 and  deadline < ?", time)

  @homeworks.destroy_all

  puts "funciono"

end


task :prueba => :environment do
	puts "HOLA MUNDO"
end
