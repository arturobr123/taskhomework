require 'openpay'

class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #scopes
	scope :nuevos, ->{order("created_at desc")}
  scope :ordenados, ->{order('name ASC')}

  #validations
  validates :last_name, presence: true

  #relations
  has_many :proposals , dependent: :destroy
  has_many :notification_workers, dependent: :destroy
  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :classrooms, dependent: :destroy
  has_many :notification_workers, dependent: :destroy
  has_many :earnings, dependent: :destroy

  has_attached_file :avatar,default_url:"/images/fondoFaurecia4.jpg"
  validates_attachment_content_type :avatar,:content_type => [/\Aimage\/.*\z/]

  include CreateToken

  def unviewed_notifications_count
    NotificationWorker.for_admin(self.id)
  end

  def send_email_info
    NotiMailer.send_info_worker_registration(self.email , self).deliver
  end


end
