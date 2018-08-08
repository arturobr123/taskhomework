class AddTransaccionidToClassrooms < ActiveRecord::Migration[5.1]
  def change
    add_column :classrooms, :transaction_id, :string
  end
end
