class AddTotalPointsToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :total_points, :integer
    add_index :recipes, :total_points
  end
end
