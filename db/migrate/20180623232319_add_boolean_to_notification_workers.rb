class AddBooleanToNotificationWorkers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :notification_workers, :viewed, :boolean
  	add_column :notification_workers, :viewed, :boolean, default: false
  end
end
