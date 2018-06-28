#CANAL DESDE LA PARTE DEL BACK END
class NotificationChannel < ApplicationCable::Channel
  def subscribed

  	puts "!!!!!!!!!!!!!!!!!!!!"

  	if current_user
  		stream_from "notifications.#{current_user.id}"
  	end

  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
