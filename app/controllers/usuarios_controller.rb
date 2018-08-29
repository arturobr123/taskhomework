require 'openpay'

class UsuariosController < ApplicationController
	before_action :set_user ,except: [:index]
	before_action :authenticate_admin!,only: [:index]
	before_action :authenticate_user!,only: [:update]
	before_action :authenticate_owner!,only: [:update]

	include OpenPay

	def index
		#lista de usuarios
		@usuarios = User.nuevos.all.paginate(page:params[:page], per_page:15)
		#cuantos usuarios hay en la lista
		@how_many_usuarios = @usuarios.count
	end

	def show
	end

	def edit
	end


	def update
		respond_to do |format|
			if @user.update(user_params)
				format.html {redirect_to my_homeworks_path, notice: "Información guardada correctamente."}
				format.js
				format.json { render :show}
			else
				format.html { render :edit }
				format.json { render json: @user.errors }
			end
		end
	end


	private
	  def set_user
		@user = User.find(params[:id])
	  end

	  def authenticate_owner!
	  	if current_user != @user
	  		redirect_to root_path, notice: "No estas autorizado"
	  	end
	  end

	  def user_params
	  	params.require(:user).permit(:email,:name, :firs_last_name,:second_last_name, :avatar)
	  end
end
