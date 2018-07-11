class AddTareaEntregadaToClassroom < ActiveRecord::Migration[5.1]
  def change

  	add_column :classrooms, :tareaEntregada, :boolean
  end
end
