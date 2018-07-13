class ChangePhraseToAdmin < ActiveRecord::Migration[5.1]
  def change
  	remove_column :admins, :phrase, :text
  	add_column :admins, :phrase, :text, default:""
  end
end
