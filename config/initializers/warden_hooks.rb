#Warden

#Devise => Login y autenticación

#INICIO DE SESION CON DEVISE
Warden::Manager.after_set_user do |user,auth,opts|

	auth.cookies.signed["user.id"] = user.id
	auth.cookies.signed["user.token"] = user.token #YES it works
	auth.cookies.signed["user.expires_at"] = 50.minutes.from_now

end



#CERRAR SESION CON DEVISE
Warden::Manager.before_logout do |user,auth,opts|
	auth.cookies.signed["user.id"] = nil
	auth.cookies.signed["user.email"] = nil
	auth.cookies.signed["user.expires_at"] = nil
	auth.cookies.signed["admin.id"] = nil
	auth.cookies.signed["admin.expires_at"] = nil

end
