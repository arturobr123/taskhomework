class AddUsuarioAceptoToClassroom < ActiveRecord::Migration[5.1]
  def change
  	remove_column :classrooms, :tareaEntregada, :boolean

  	add_column :classrooms, :user_accepts, :boolean
  end
end
