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



    


    #REGRESAR DINERO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    request_hash={
      "description" => "Monto de cargo devuelto",
      "amount" => 500.00
    }

    # @charges=openpay.create(:charges)

    # #transaccion_id,  user_id
    # response_hash= @charges.refund("trl0x4zfsiiy8kifsbck", request_hash.to_hash, "adcuzsxm7ndvah1xfmoh")

    # puts response_hash







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










    # @trabajadores = Admin.all

    # #CUSTOMERS
    # @customers= openpay.create(:customers)
    # #COMISIONES
    # @fees = openpay.create(:fees)
    # #pagos a CLABE
    # @payouts = openpay.create(:payouts)


    #OBTENER LAS COMISIONES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # @trabajadores.each do |trabajador|
    #   puts trabajador.name

    #   if(trabajador.open_pay_user_id && trabajador.open_pay_clabe_id)

    #     response_hash = @customers.get(trabajador.open_pay_user_id)

    #     #puts response_hash
    #     puts " !! "
    #     puts " !! "
    #     puts response_hash["balance"]

    #     #si vemos que tiene un balance > 10, le hacemos la comision
    #     #esto se hace asi porque cada 14 dias se estan haciendo las comisiones
    #     #y vaciando las cuentas, por lo tanto, cada 14 dias las cuentas inician en 0
    #     @total = response_hash["balance"].to_i
    #     if(@total > 10)

    #       comision = @total * 0.05

    #       puts comision.to_s

    #       new_fee_hash={
    #         "customer_id" => trabajador.open_pay_user_id,
    #         "amount" => comision,
    #         "description" => "Cobro de Comisión"
    #       }

    #       begin
    #         @fees.create(new_fee_hash.to_h)
    #       rescue Exception => e
    #         puts e.description# => 'The api key or merchant id are invalid.'
    #       end

    #       puts "EXITO EN COMISION!!"


    #     end        

    #   end

    # end



    
    # @payouts = openpay.create(:payouts)

    # #AHORA TOCA HACER EL DEPOSITO A LA "CLABE" DEL TRABAJADOR
    # request_hash={
    #   "method" => "bank_account",
    #   "destination_id" => "bmnxej10hbgvdszb4zt8",   
    #   "amount" => 200,
    #   "description" => "Retiro de saldo id:20"
    # }

    # begin
    #   @payouts.create(request_hash.to_hash, "a4i1spe6t5lkxqbwo8dm")
    # rescue Exception => e
    #   puts e.description# => 'The api key or merchant id are invalid.'
    #   puts e.description# => 'The api key or merchant id are invalid.'
    # end

    # puts "FUNCIONO !!!!!!!"








    #envio de pagos
    # @trabajadores.each do |trabajador|
    #   puts trabajador.name

    #   if(trabajador.open_pay_user_id && trabajador.open_pay_clabe_id)

    #     puts "ENTRO AQUI !!!!"
    #     response_hash = @customers.get(trabajador.open_pay_user_id)

    #     @total = response_hash["balance"].to_f
    #     if(@total > 0)

    #       puts "EL TRABAJADOR TIENE BALANCE"
    #       #AHORA TOCA HACER EL DEPOSITO A LA "CLABE"  DEL TRABAJADOR
    #       request_hash={
    #         "method" => "bank_account",
    #         "destination_id" => trabajador.open_pay_clabe_id,   
    #         "amount" => 200,
    #         "description" => "Retiro de saldo id: #{trabajador.id}"
    #       }

    #       begin
    #         @payouts.create(request_hash.to_hash, trabajador.open_pay_user_id)
    #       rescue Exception => e
    #         puts e.description# => 'The api key or merchant id are invalid.'
    #       end

    #       puts "EXITO MANDANDO EL DEPOSITO"

    #     end        

    #   end

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
