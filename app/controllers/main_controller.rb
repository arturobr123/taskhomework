require "conekta"

class MainController < ApplicationController

  def home
  end

  def homeAdmin


    Conekta.api_key = "key_DTKd5scbHqYPzahsJBvm5w"

    #CREAR CUSTOMER EN CONEKTA
    # customer = Conekta::Customer.create({
    #   :name => "Mario Perez",
    #   :email => "usuario@example.com",
    #   :phone => "+5215555555555",
    #   :payment_sources => [{
    #     :token_id => "tok_test_visa_4242",
    #     :type => "card"
    #   }],
    #   :shipping_contacts => [{
    #     :phone => "+5215555555555",
    #     :receiver => "Marvin Fuller",
    #     :address => {
    #       :street1 => "Nuevo Leon 4",
    #       :country => "MX",
    #       :postal_code => "06100"
    #     }
    #   }]
    # })


    # Conekta::Order.create({
    #   :currency => "MXN",
    #   :customer_info => {
    #     :customer_id => "cus_2ipm77xEcrk5nLwxv"
    #   },
    #   :line_items => [{
    #     :name => "Box of Cohiba S1s",
    #     :unit_price => 35000,
    #     :quantity => 1
    #   }],
    #   :charges => [{
    #     :payment_method => {
    #       :type => "default"
    #     }
    #   }]
    # })

    puts "!!!!!!!!!!!!!!!"
    puts "!!!!!!!!!!!!!!!"
    puts "!!!!!!!!!!!!!!!"
    puts "!!!!!!!!!!!!!!!"
    puts "!!!!!!!!!!!!!!!"
    puts "!!!!!!!!!!!!!!!"

  	redirect_to my_homeworks_path




  end

  def homeUser
  	redirect_to my_homeworks_path
  end

  def userUnregistered
  	#redirect_to new_user_registration_path
    redirect_to home_page_path
  end

  def adminUnregistered
  	#redirect_to new_admin_registration_path
    redirect_to home_page_path
  end

end
