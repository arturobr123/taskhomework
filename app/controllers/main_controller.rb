require 'openpay'


class MainController < ApplicationController

  def home
  end

  def homeAdmin

    respond_to do |format|
      if(current_admin.open_pay_clabe_id.nil?)
        format.html { redirect_to clabeAccount_path, notice: "Por favor ingresa tu CLABE donde le estaremos depositando sus ganancias" }
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
    # merchant_id='mnn5gyble3oezlf6ca3v'
    # private_key='sk_33044f35a7364f81b7139b21327a5927'
    # openpay=OpenpayApi.new(merchant_id,private_key)





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










    # @trabajadores = Admin.where("open_pay_user_id not ? and open_pay_clabe_id not ?", nil,nil)

    # #CUSTOMERS
    # @customers= openpay.create(:customers)
    # #COMISIONES
    # @fees = openpay.create(:fees)
    # #pagos a CLABE
    # @payouts = openpay.create(:payouts)


    # #OBTENER LAS COMISIONES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # @trabajadores.each do |trabajador|
    #   puts trabajador.name
    #   puts trabajador.last_name

    #   if(trabajador.open_pay_user_id && trabajador.open_pay_clabe_id)

    #     response_hash = @customers.get(trabajador.open_pay_user_id)

    #     #saldo que tiene en su cuenta
    #     puts "balance: " + response_hash["balance"]

    #     #para cada trabajador de comision le sacamos todo lo que tiene en su cuenta
    #     @total = response_hash["balance"].to_i
    #     if(@total > 0)

    #       @comision = @total

    #       puts "total de dinero: " + @comision.to_s

    #       new_fee_hash={
    #         "customer_id" => trabajador.open_pay_user_id,
    #         "amount" => @comision,
    #         "description" => "Cobro de Comisión al trabajador con id: #{trabajador.open_pay_user_id}"
    #       }

    #       begin
    #         @fees.create(new_fee_hash.to_h)
    #       rescue Exception => e
    #         puts e.description
    #       end

    #       puts "EXITO EN COMISION!!"

    #       #ahora para cada trabajador a su saldo que tenia le quitamos el %5 porciento
    #       #y lo demas se lo depositamos a su cuenta CLABE
    #       @pago_final = @comision - (@comision * 0.05)
    #       puts "pago final quitando comision: #{@pago_final.to_s}"

    #       request_hash={
    #         "method" => "bank_account",
    #         "destination_id" => trabajador.open_pay_clabe_id,   
    #         "amount" => @pago_final,
    #         "description" => "pago del trabajador con id: #{trabajador.id}"
    #       }

    #       begin
    #         @payouts.create(request_hash.to_hash, trabajador.open_pay_user_id)
    #       rescue Exception => e
    #         puts e.description
    #         puts e.json_body
    #       end

    #       puts "EXITO EN ENVIO DE DINERO!!"


    #     end        

    #   end

    # end




    #envio de pagos
    # @trabajadores.each do |trabajador|
    #   puts trabajador.name

    #   if(trabajador.open_pay_user_id && trabajador.open_pay_clabe_id)

    #     puts "ENTRO AQUI !!!!"
    #     response_hash = @customers.get(trabajador.open_pay_user_id)

    #     @total = response_hash["balance"].to_f
    #     if(@total > 0)

    #       puts "EL TRABAJADOR TIENE BALANCE"
    #       puts @total

    #       puts trabajador.open_pay_user_id
    #       #AHORA TOCA HACER EL DEPOSITO A LA "CLABE"  DEL TRABAJADOR
    #       request_hash={
    #         "method" => "bank_account",
    #         "destination_id" => trabajador.open_pay_clabe_id,   
    #         "amount" => 10.50,
    #         "description" => "Retiro de saldo id: #{trabajador.id}"
    #       }

    #       begin
    #         @payouts.create(request_hash.to_hash, trabajador.open_pay_user_id)
    #       rescue Exception => e
    #         puts e.description# => 'The api key or merchant id are invalid.'
    #         puts e.json_body
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
    #   request = transfers.create(new_transaction_hash.to_h, "afab2dieo94yhjxbsh2s") #de aqui se sacara el dinero
    #   puts request
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
