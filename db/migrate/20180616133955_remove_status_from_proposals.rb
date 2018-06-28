class RemoveStatusFromProposals < ActiveRecord::Migration[5.1]
  def change
  	remove_column :proposals, :status, :integer

  	add_column :proposals, :status, :integer, default: 1
  end
end
