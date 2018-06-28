class AddPolimorficToNotificationWorkers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :notification_workers, :item, :string

  	add_reference :notification_workers, :item, polymorphic: true, index:true
  end
end
