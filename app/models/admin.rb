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

  #despues de que el trabajador es creado, se crea su cuenta en openpay
  after_create_commit :create_openpay_account

  include CreateToken

  #este metodo crea el perfil del trabajador en openpay al momento de registrarlo
  def create_openpay_account
    #merchant and private key
    merchant_id='mnn5gyble3oezlf6ca3v'
    private_key='sk_33044f35a7364f81b7139b21327a5927'
    openpay=OpenpayApi.new(merchant_id,private_key)

    new_client_hash={
        "name" => self.name,
        "last_name" => self.last_name,
        "email" => self.email
     }

    customers = openpay.create(:customers)

    begin
      @customer = customers.create(new_client_hash.to_h)
    rescue Exception => e
      puts e.json_body
    end

    Admin.find(self.id).update!(open_pay_user_id: @customer["id"])
  end


  def unviewed_notifications_count
    NotificationWorker.for_admin(self.id)
  end


end
