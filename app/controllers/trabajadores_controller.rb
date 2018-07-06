class TrabajadoresController < ApplicationController
	before_action :set_worker ,except: [:index]
	before_action :authenticate_admin!,only: [:index] #gema devise
	before_action :authenticate_admin!,only: [:update]
	before_action :authenticate_owner!,only: [:update]

	def index

		#lista de usuarios
		@usuarios = Admin.nuevos.all.paginate(page:params[:page], per_page:15)
		#cuantos usuarios hay en la lista
		@how_many_usuarios = @usuarios.count

	end
	
	def show
		@proposals = @admin.proposals.nuevos.paginate(page:params[:page], per_page:15)
		@proposals_money = @admin.proposals.where(status: 3).nuevos

		@money = 0 #total de ganancias

		@proposals_money.each do |proposal|
			@money = @money + proposal.cost
		end
	end


	def edit
	end


	def update
		
		respond_to do |format|
			if @admin.update(user_params)
				format.html {redirect_to current_admin, notice: "información guardada correctamente"}
				format.js
				format.json { render :show}
			else
				format.html { render :edit }
				format.json { render json: @admin.errors }
			end
		end
	end


	private
	  def set_worker
		@admin = Admin.find(params[:id])
	  end

	  def authenticate_owner!
	  	if current_admin != @admin
	  		redirect_to root_path, notice: "No estas autorizado"
	  		
	  	end
	  	
	  end

	  def user_params
	  	params.require(:admin).permit(:email,:name, :avatar)
	  	
	  end
end
