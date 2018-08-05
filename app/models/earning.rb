class Earning < ApplicationRecord
  scope :nuevos, ->{order("created_at desc")}
  belongs_to :admin
end
