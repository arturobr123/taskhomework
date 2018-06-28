class Proposal < ApplicationRecord
  belongs_to :admin
  belongs_to :homework

  #relations
  belongs_to :admin
  belongs_to :homework

  has_one :classroom

  #scopes
  scope :nuevos, ->{order("created_at desc")}


  #incluye el concern Notificable
	include Notificable
  
  #a quien enviará la notificación
  def user_ids
  	return self.homework.user.id
  end

end
