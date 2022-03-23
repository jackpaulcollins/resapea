class RemoveQuantityAndMeasurementUnitFromRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipe_ingredients, :quantity
    remove_column :recipe_ingredients, :measurement_unit
  end
end
