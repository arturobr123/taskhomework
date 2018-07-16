module OpenPay
  extend ActiveSupport::Concern
	
	def open_pay_var
		#merchant and private key
		merchant_id = 'mnn5gyble3oezlf6ca3v'
		private_key ='sk_33044f35a7364f81b7139b21327a5927'
		@openpay = OpenpayApi.new(merchant_id,private_key)
		return @openpay
	end
  
end