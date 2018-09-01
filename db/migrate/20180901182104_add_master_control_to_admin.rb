class AddMasterControlToAdmin < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :master_control, :boolean, default: false
  end
end
