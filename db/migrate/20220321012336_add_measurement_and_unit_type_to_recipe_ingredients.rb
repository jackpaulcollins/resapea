class AddMeasurementAndUnitTypeToRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :recipe_ingredients, :measurement_unit_type, :string
    add_column :recipe_ingredients, :measurement_unit_quantity, :integer
  end
end
