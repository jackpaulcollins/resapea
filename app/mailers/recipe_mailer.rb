class RecipeMailer < ActionMailer::Base
  default from: "jack@respea.io"
  def email_recipe_to_user(recipe, user)
    @user = user
    @recipe = recipe
    mail(to: @user.email, subject: "Here's the Recipe you asked for!")
  end
end