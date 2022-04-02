class InstructionBlueprint < Blueprinter::Base
  identifier :id

  fields :recipe_id, :content, :position
end