class CommentBlueprint < Blueprinter::Base
  identifier :id

  fields :content, :created_at, :updated_at, :user
  association :user, blueprint: UserBlueprint
end