class ChangeIngredientColumnNameType < ActiveRecord::Migration[5.2]
  def change
    rename_column :ingredients, :type, :food_group
  end
end
