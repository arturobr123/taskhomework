class NotificationWorkerChannel < ApplicationCable::Channel
  def subscribed

  	# puts "÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷"

  	# if current_admin
  	# 	stream_from "notificationsWorker.#{current_admin.id}"
  	# end

  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
