require "stripe"
class ChargesController < ApplicationController

	def new
		
		customer = Stripe::Customer.retrieve(current_user.stripe_customer_token)
		puts customer

	end

	def create

	  # Amount in cents
	  @amount = 500

	  customer = Stripe::Customer.create(
	    :email => params[:stripeEmail], #params[:stripeEmail]
	    :source  => params[:stripeToken] #card token
	  )

	  puts customer.id #customer token

	  if current_user
	  	current_user.update!(stripe_customer_token: customer.id)
	  end

	  if current_admin
	  	current_admin.update!(stripe_customer_token: customer.id)
	  end

	  respond_to do |format|
  		format.html { redirect_to root_path, notice: 'Información guardada de manera correcta' }
  		format.js
  	end


	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to root_path
	end

end
