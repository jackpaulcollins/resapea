class RecipeBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :genre, :user_id, :total_points, :photo_url, :created_at, :compatibilities, :cuisine
  association :recipe_ingredients, blueprint: RecipeIngredientBlueprint
  association :instructions, blueprint: InstructionBlueprint
  association :comments, blueprint: CommentBlueprint
  association :votes, blueprint: VoteBlueprint
  association :user, blueprint: UserBlueprint
end