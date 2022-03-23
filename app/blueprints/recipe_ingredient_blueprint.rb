class RecipeIngredientBlueprint < Blueprinter::Base
  identifier :id

  fields :recipe_id, :ingredient_name, :measurement_unit_quantity, :measurement_unit_type
end