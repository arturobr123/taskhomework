class TC::Level < ApplicationRecord
  scope :ordenados, ->{order('tipo ASC')}
end
