class RemoveIngredientIdAndAndNameToFromRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipe_ingredients, :ingredient_id
    add_column :recipe_ingredients, :ingredient_name, :string
  end
end
