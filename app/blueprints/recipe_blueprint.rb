class RecipeBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :genre, :user_id, :total_points
  association :recipe_ingredients, blueprint: RecipeIngredientBlueprint
  association :instructions, blueprint: InstructionBlueprint
  association :comments, blueprint: CommentBlueprint
  association :votes, blueprint: VoteBlueprint
end