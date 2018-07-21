class Proposal < ApplicationRecord
  belongs_to :admin
  belongs_to :homework

  #relations
  belongs_to :admin
  belongs_to :homework

  has_one :classroom

  #scopes
  scope :nuevos, ->{order("created_at desc")}

  after_create_commit :notify_user

  #validaciones
  validates :cost, presence: true
  validates :deadline, presence: true
  validate :expiration_date_cannot_be_in_the_past,:on => :create

  #incluye el concern Notificable
	include Notificable

  #a quien enviará la notificación
  def user_ids
  	return self.homework.user.id
  end

  #despues de crear la propuesta, se envia correo notificacion al usuario
  def notify_user
    NotiMailer.notification_proposal(self.homework.user.email, self, self.homework).deliver
  end

  def expiration_date_cannot_be_in_the_past
    if(deadline < DateTime.now || deadline > self.homework.deadline)
      errors.add(:deadline, "can't be in the past or before the deadline homework") 
    end
  end

end
