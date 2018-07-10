module ApplicationCable
  class Connection < ActionCable::Connection::Base

  	identified_by :current_user #just a name
    identified_by :current_admin #just a name

  	def connect

      puts "!!!!!!!!!!!!!!"

  		self.current_user = find_user
      self.current_admin = find_admin
  		
  	end

  	#encuentra el usuario actual
  	def find_user

      puts cookies.signed["user.token"]
      token = cookies.signed["user.token"]

  		current_user = User.find_by_token(token) #find_by => si no encuentra un usuario retorna nulo en lugar de marcar error

  		if current_user
  			return current_user
  		else
  			#reject_unauthorized_connection
        return nil
  		end
  		
  	end

    #encuentra el worker actual
    def find_admin

      puts cookies.signed["user.token"] #SI FUNCIONA!!
      token = cookies.signed["user.token"]

      current_admin = Admin.find_by_token(token) #find_by => si no encuentra un usuario retorna nulo en lugar de marcar error

      if current_admin
        return current_admin
      else
        #reject_unauthorized_connection
        return nil
      end
      
    end

  end
end


#find_by
# returns the first item or nil.






