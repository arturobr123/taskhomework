class Message < ApplicationRecord
  # belongs_to :user
  # belongs_to :admin
  belongs_to :chat_room

  validates :body, presence: true, length: {minimum: 2, maximum: 1000}

  after_create_commit { MessageBroadcastJob.perform_later(self)}
  after_create_commit :send_message_email

  def timestamp
	  created_at.strftime('%H:%M:%S %d %B %Y')
	end

  def send_message_email
    if(self.user_id)
      @classroom = self.chat_room.classroom
      NotiMailer.send_message_classroom(@classroom.admin.email, @classroom.homework,@classroom, self.body).deliver
    end

    if(self.admin_id)
      @classroom = self.chat_room.classroom
      NotiMailer.send_message_classroom(@classroom.user.email, @classroom.homework,@classroom, self.body).deliver
    end
  end

end
