class ChatRoom < ApplicationRecord
  belongs_to :user
  belongs_to :admin
  belongs_to :classroom

  has_many :messages, dependent: :destroy
end
