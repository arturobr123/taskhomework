class Homework < ApplicationRecord

	scope :nuevos, ->{order("created_at desc")}

  belongs_to :user
  #belongs_to :admin

  #relations
  has_many :proposals , dependent: :destroy
  has_many :classrooms , dependent: :destroy
  has_many :archives, :dependent => :destroy


  #enviara una notifiacion al usuario cuando su tarea se finalize
  after_update_commit :send_notification_to_users_finish_homework

  #a quien enviará la notificación
  def user_ids
  	return self.user.id
  end

  def send_notification_to_users_finish_homework
  	if(self.status == 3) #si la tarea tiene el status finalizada
  		if self.respond_to? :user_ids #checa que tenga el metodo user_ids
				#JOB => mandar notificaciones asyncronas
				NotificationSenderJob.perform_later(self)
        NotiMailer.notification_finished_homework(self.user.email, self.classrooms.first, self).deliver 
			end
  	end
  end


  #validaciones
  validates :name, presence: true
  validates :tipo, presence: true
  validates :level, presence: true
  validates :maxPrice, presence: true
  validates :description, presence: true
  validates :deadline, presence: true
  validates :minPrice, numericality: { greater_than_or_equal_to: 100 }
  validate :expiration_date_cannot_be_in_the_past


  def expiration_date_cannot_be_in_the_past
    if deadline.present? && deadline < DateTime.now
      errors.add(:deadline, "can't be in the past")
    end
  end 

  
end
