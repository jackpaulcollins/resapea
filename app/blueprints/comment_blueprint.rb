# frozen_string_literal: true

class CommentBlueprint < Blueprinter::Base
  identifier :id

  fields :content, :created_at, :updated_at, :user, :total_points
  association :user, blueprint: UserBlueprint
  association :votes, blueprint: VoteBlueprint
  association :replies, blueprint: CommentBlueprint
end
