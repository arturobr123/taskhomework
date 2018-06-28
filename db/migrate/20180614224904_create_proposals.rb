class CreateProposals < ActiveRecord::Migration[5.1]
  def change
    create_table :proposals do |t|
      t.references :admin, foreign_key: true
      t.references :homework, foreign_key: true
      t.float :cost
      t.text :notes
      t.integer :status

      t.timestamps
    end
  end
end
