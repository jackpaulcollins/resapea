class VoteBlueprint < Blueprinter::Base
  identifier :id

  fields :vote_type, :user_id
end