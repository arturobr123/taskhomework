class TrabajadoresController < ApplicationController
	before_action :set_worker ,except: [:index, :clabe, :phrase, :first_phrase,:upload_clabe, :upload_clabe_open_pay]
	before_action :authenticate_admin!,only: [:index, :update, :clabe, :phrase, :first_phrase,:upload_clabe, :upload_clabe_open_pay] #gema devise
	before_action :authenticate_owner!,only: [:update]

	include OpenPay

	def index
		#lista de usuarios
		@usuarios = Admin.nuevos.all.paginate(page:params[:page], per_page:15)
		#cuantos usuarios hay en la lista
		@how_many_usuarios = @usuarios.count
	end

	def show
		@proposals = @admin.proposals.nuevos.paginate(page:params[:page], per_page:15)
		@classrooms = @admin.classrooms.where(user_accepts: true)

		##open pay
		@money = 0
		@openpay = open_pay_var()
		@customers= @openpay.create(:customers)
		response_hash = @customers.get(current_admin.open_pay_user_id)
		if response_hash["balance"]
			@money = response_hash["balance"]
			@money = @money - ((@money * 0.179) + 2.5)
		end

		if @money < 0
			@money = 0
		end

	end


	def edit

		if current_admin.phrase
      @phrase = current_admin.phrase
    else
      @phrase = ""
    end

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

	def clabe

		if current_admin.open_pay_clabe_id

			@openpay = open_pay_var()

			@bank_accounts=@openpay.create(:bankaccounts)

			begin
				@response_hash = @bank_accounts.get(current_admin.open_pay_user_id, current_admin.open_pay_clabe_id)
			rescue Exception => e
				puts e
			end

			if @response_hash["clabe"]
				@openpay_clabe = @response_hash["clabe"]
			end

		end

	end

	def upload_clabe
		clabe = params[:clabe]

		@clabe = upload_clabe_open_pay(clabe)

    respond_to do |format|
			if @clabe[0] == true
				format.html {redirect_to phrase_path, notice: @clabe[1]}
			else
				format.html {redirect_back(fallback_location: root_path, notice: @clabe[1])}
			end
		end
	end


	def upload_clabe_open_pay(clabe)

    openpay = open_pay_var()

		#OBTENER COMISIONES
		request_hash={
		 "holder_name" => current_admin.name + " " + current_admin.last_name,
		 "alias" => "Cuenta principal",
		 "clabe" => clabe
		}

    @bank_accounts= openpay.create(:bankaccounts)

    begin
      response_hash=@bank_accounts.create(request_hash.to_hash, current_admin.open_pay_user_id)
    rescue Exception => e
      return[false, "erro: #{e.description.to_s}"]
    end

    current_admin.update(open_pay_clabe_id: response_hash["id"])
    return [true,"Subida de CLABE exitoso !"]
	end


	def first_phrase
		phrase = params[:phrase]

		respond_to do |format|
			if current_admin.update!(phrase: phrase)
				format.html {redirect_to homeworks_path, notice: "Bienvenido a Task, ahora puedes buscar tareas y subir propuestas. Exito!"}
			else
				format.html {redirect_back(fallback_location: root_path, notice: "ocurrio un error, intentalo nuevamente")}
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
	  	params.require(:admin).permit(:email,:name, :avatar, :phrase)

	  end
end
