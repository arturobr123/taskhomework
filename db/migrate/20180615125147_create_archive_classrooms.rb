class CreateArchiveClassrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :archive_classrooms do |t|

      t.timestamps
    end
  end
end
