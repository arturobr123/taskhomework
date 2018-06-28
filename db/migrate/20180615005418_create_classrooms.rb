class CreateClassrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :classrooms do |t|
      t.references :homework, foreign_key: true
      t.integer :status
      t.references :user, foreign_key: true
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
