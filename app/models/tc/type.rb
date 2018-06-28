class TC::Type < ApplicationRecord
	scope :ordenados, ->{order('tipo ASC')}
end
