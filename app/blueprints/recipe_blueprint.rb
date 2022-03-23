class RecipeBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :genre, :user_id
  association :recipe_ingredients, blueprint: RecipeIngredientBlueprint
  association :instructions, blueprint: InstructionBlueprint
end