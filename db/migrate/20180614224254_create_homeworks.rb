class CreateHomeworks < ActiveRecord::Migration[5.1]
  def change
    create_table :homeworks do |t|
      t.datetime :deadline
      t.text :description
      t.text :name
      t.integer :numberpages
      t.integer :status
      t.integer :type
      t.references :user, foreign_key: true
      t.references :admin, foreign_key: true
      t.integer :level

      t.timestamps
    end
  end
end
