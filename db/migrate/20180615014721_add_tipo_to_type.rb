class AddTipoToType < ActiveRecord::Migration[5.1]
  def change
  	remove_column :types, :type, :text

    add_column :types, :tipo, :text
  end
end
