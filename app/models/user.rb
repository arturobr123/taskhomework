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

  include CreateToken

  def unviewed_notifications_count
    Notification.for_user(self.id)
  end


end
