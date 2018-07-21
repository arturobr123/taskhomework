class AddTypeToNotificationsWorker < ActiveRecord::Migration[5.1]
  def change
    add_column :notification_workers, :notification_type, :string, default: ""
  end
end
