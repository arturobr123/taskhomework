class CreateNotificationWorkers < ActiveRecord::Migration[5.1]
  def change
    create_table :notification_workers do |t|
      t.references :admin, foreign_key: true
      t.string :item
      t.boolean :viewed

      t.timestamps
    end
  end
end
