class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable

	#scopes
	scope :nuevos, ->{order("created_at desc")}
  scope :ordenados, ->{order('name ASC')}

	#relations
  has_many :homeworks , dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  #validaciones
  validates :name, presence: true
  validates :firs_last_name, presence: true
  validates :second_last_name, presence: true

  has_attached_file :avatar,default_url:"/images/fondoFaurecia4.jpg"
  validates_attachment_content_type :avatar,:content_type => [/\Aimage\/.*\z/]

	after_create_commit :send_email_info

  include CreateToken

  def unviewed_notifications_count
    Notification.for_user(self.id)
  end

	#cuando el usuario se registra, enviarle un correo con la información,
	def send_email_info
		NotiMailer.send_info_student_registration(self.email , self).deliver
	end


end
