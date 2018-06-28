class AddReferenceToArchives < ActiveRecord::Migration[5.1]
  def change
  	add_reference :archives, :homework, foreign_key: true
  end
end
