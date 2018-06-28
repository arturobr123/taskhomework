module ApplicationCable
  class Connection < ActionCable::Connection::Base

  	identified_by :current_user
    #identified_by :current_admin

  	def connect
  		self.current_user = find_user
      #self.current_admin = find_admin
  		
  	end

  	#encuentra el usuario actual
  	def find_user
  		user_id = cookies.signed["user.id"]

  		current_user = User.find_by(id: user_id) #find_by => si no encuentra un usuario retorna nulo en lugar de marcar error

  		if current_user
  			return current_user
  		else
  			reject_unauthorized_connection
        #return nil
  		end
  		
  	end

    #encuentra el worker actual
    def find_admin
      admin_id = cookies.signed["admin.id"]

      current_admin = Admin.find_by(id: admin_id) #find_by => si no encuentra un usuario retorna nulo en lugar de marcar error

      if current_admin
        return current_admin
      else
        #reject_unauthorized_connection
        return nil
      end
      
    end

  end
end









