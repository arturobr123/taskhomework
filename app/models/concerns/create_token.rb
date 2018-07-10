module CreateToken
	extend ActiveSupport::Concern

	included do
	  after_commit :create_token, :on => :create
	end

	def create_token
		token = SecureRandom.hex(13)
		self.class.where('id = ?', self.id).update_all(:token => token)
	end

end


