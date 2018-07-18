class NotificationsworkerController < ApplicationController

	def index
  	@notifications = NotificationWorker.where(admin:current_admin).unviewed.latest.paginate(page:params[:page], per_page:10)
  	respond_to do |format|
  		format.html
  		format.js
  	end
  end

  def update
  	@notification = NotificationWorker.find(params[:id])
  	message = if @notification.update(notification_params)
  		"Notificacion Vista"
  	else
  		"Hubo un error"
  	end
  	redirect_back fallback_location: root_path
  end


  #es poner todas las notificaciones como vistas
  def view_all_notifications_worker
    @notifications = NotificationWorker.where(admin:current_admin).unviewed

    @notifications.each do |notification|
      NotificationWorker.update(notification.id, :viewed => true)
    end

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Todas las notificaciones vistas' }
      format.js
    end
  end

  private
  def notification_params
  	params.require(:notification).permit(:viewed)
  		
  end

end
