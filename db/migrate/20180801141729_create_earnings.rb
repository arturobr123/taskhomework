class CreateEarnings < ActiveRecord::Migration[5.1]
  def change
    create_table :earnings do |t|
      t.float :money
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
