class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.text :score
      t.timestamps
    end
  end
end
