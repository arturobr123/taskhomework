require 'openpay'


class MainController < ApplicationController

  def home
  end

  def homeAdmin

    respond_to do |format|
      if(current_admin.open_pay_clabe_id.nil?)
        format.html { redirect_to clabeAccount_path, notice: "Por favor ingresa tu CLABE" }
      else
        format.html { redirect_to my_homeworks_path }

      end
    end

  end

  def homeUser
  	redirect_to my_homeworks_path
  end

  def userUnregistered
  	#redirect_to new_user_registration_path
    redirect_to home_page_path

    #merchant and private key
    merchant_id='mnn5gyble3oezlf6ca3v'

    private_key='sk_33044f35a7364f81b7139b21327a5927'

    openpay=OpenpayApi.new(merchant_id,private_key)






    #CREATE NEW CUSTOMER
    new_client_hash={
        "name" => "Batman",
        "last_name" => "Bravo",
        "email" => "batman_task@hotmail.com"
     }

    # customers=openpay.create(:customers)

    # resp = customers.create(new_client_hash.to_h)
    # puts resp




    #CREATE CARD TO CUSTOMER
    new_card_hash={
        "holder_name" => "Deadpool Bravo",
        "card_number" => 4242424242424242,
        "cvv2" => 123,
        "expiration_month" => 12,
        "expiration_year" => 20
     }

    # cards=openpay.create(:cards)

    # resp = cards.create(new_card_hash.to_h, "afab2dieo94yhjxbsh2s")
    # puts resp





    #CREATE A CHARGE TO THE CUSTOMER ;esto le agrega saldo a un usuario (se pueden hacer cargos de otros modos)
    request_hash={
        "method" => "card",
        "source_id" => "klshss9zrujnygnydwgc",
        "amount" => 600.00,
        "currency" => "MXN",
        "description" => "Cargo inicial a mi merchant",
        "device_session_id" => "kR1MiQhz2otdIuUlQkbEyitIqVMiI16f",
        "order_id" => "elshss9zrujnygnydwgca" #este id puede ser inventado pero debe ser unico
    }

    # charges=openpay.create(:charges)

    # begin
    #   charges.create(request_hash.to_h, "afab2dieo94yhjxbsh2s")
    # rescue Exception => e
    #   puts e.http_code  #  => 401
    #   puts e.error_code # => 1002
    #   puts e.description# => 'The api key or merchant id are invalid.'
    #   puts e.json_body #  {"category":"request","description":"The api key or merchant id are invalid.","http_code":401,"error_code":1002,"request_id":null}
    # end





    #OBTENER COMISIONES
    new_fee_hash={
       "customer_id" => "afab2dieo94yhjxbsh2s",
       "amount" => 12.50,
       "description" => "Cobro de Comisión"
     }

    # fees= openpay.create(:fees)

    # begin
    #   fees.create(new_fee_hash.to_h)
    # rescue Exception => e
    #   puts e.http_code  #  => 401
    #   puts e.error_code # => 1002
    #   puts e.description# => 'The api key or merchant id are invalid.'
    #   puts e.json_body #  {"category":"request","description":"The api key or merchant id are invalid.","http_code":401,"error_code":1002,"request_id":null}
    # end






    #HACER TRANSFERENCIAS ENTRE CLIENTES USUARIOS
    new_transaction_hash={
       "customer_id" => "a1srmitluvr17rncwwfp",
       "amount" => 500,
       "description" => "Transferencia entre cuentas"
     }

    # transfers=openpay.create(:transfers)

    # begin
    #   transfers.create(new_transaction_hash.to_h, "afab2dieo94yhjxbsh2s") #de aqui se sacara el dinero
    # rescue Exception => e
    #   puts e.http_code  #  => 401
    #   puts e.error_code # => 1002
    #   puts e.description# => 'The api key or merchant id are invalid.'
    #   puts e.json_body #  {"category":"request","description":"The api key or merchant id are invalid.","http_code":401,"error_code":1002,"request_id":null}
    # end




  end

  def adminUnregistered
  	#redirect_to new_admin_registration_path
    redirect_to home_page_path
  end

end
