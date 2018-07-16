require 'openpay'

class UsuariosController < ApplicationController
	before_action :set_user ,except: [:index]
	before_action :authenticate_admin!,only: [:index] #gema devise
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

		@openpay = open_pay_var()

		@cards=@openpay.create(:cards)

		@card_numer = ""

		if current_user.card_id && current_user.open_pay_user_id

			begin
			  @require_hash = @cards.get(current_user.card_id, current_user.open_pay_user_id)
			rescue Exception => e
			  puts e.description.to_s
			end

			if @require_hash
				@card_numer = @require_hash["card_number"]
			end
			
		end

	end


	def update
		respond_to do |format|
			if @user.update(user_params)

				#subida de tarjeta
        if params[:card].length > 0 && params[:cc_cvc].length > 0 && params[:date][:month] && params[:date][:year]
        	result = upload_card(params[:card],params[:cc_cvc],params[:date][:month],params[:date][:year])
        end

        if(result)
        	notice = result
        else
        	notice = "Información guardada correctamente"
        end

				format.html {redirect_to my_homeworks_path, notice: notice}
				format.js
				format.json { render :show}
			else
				format.html { render :edit }
				format.json { render json: @user.errors }
			end
		end
	end


	def upload_card(card_number, cvv2, expiration_month, expiration_year)

	    openpay = open_pay_var()

	    #CREATE NEW CUSTOMER
	    if(!current_user.open_pay_user_id)

		    new_client_hash={
		        "name" => current_user.name,
		        "last_name" => current_user.firs_last_name,
		        "email" => current_user.email
		     }

		    customers = openpay.create(:customers)

		    begin
				  @customer = customers.create(new_client_hash.to_h)
				rescue Exception => e
				  puts e #  {"category":"request","description":"The api key or merchant id are invalid.","http_code":401,"error_code":1002,"request_id":null}
				  return "ERROR generando usuario para cuenta: #{e.description}"
				end

				puts @customer
				@customer_id = @customer["id"]
			else
				@customer_id = current_user.open_pay_user_id
		  end
	    
		#CREATE CARD TO CUSTOMER
    new_card_hash={
        "holder_name" => current_user.name + " " + current_user.firs_last_name,
        "card_number" => card_number,
        "cvv2" => cvv2,
        "expiration_month" => expiration_month,
        "expiration_year" => expiration_year[2,3]
     }

    cards = openpay.create(:cards)

    begin
		  @card = cards.create(new_card_hash.to_h, @customer_id)
		rescue Exception => e
		  puts e.description #  {"category":"request","description":"The api key or merchant id are invalid.","http_code":401,"error_code":1002,"request_id":null}
			return "ERROR con la tarjeta: #{e.description}"
		end

		#actualiza el id del customer y el id de la tarjeta
		current_user.update!(open_pay_user_id:@customer_id, card_id: @card["id"])

		return nil
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
