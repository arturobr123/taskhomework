class AddDateToProposals < ActiveRecord::Migration[5.1]
  def change
  	add_column :proposals, :deadline, :datetime
  end
end
