class AddMinimummaximumToHomework < ActiveRecord::Migration[5.1]
  def change
  	add_column :homeworks, :minPrice, :integer
  	add_column :homeworks, :maxPrice, :integer
  end
end
