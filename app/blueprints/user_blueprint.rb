class UserBlueprint < Blueprinter::Base
  identifier :id
  field :email, name: :login

  view :normal do
    fields :first_name, :last_name
  end
end