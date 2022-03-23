class RecipesController < ApplicationController
  def index
    @recipes = RecipeBlueprint.render(Recipe.all)

    render json: { data: @recipes }
  end

  def create
   op = CreateRecipeOp.new(recipe_params.to_h)
   if op.valid?
    op.execute
    render json: { status: 200, message: "recipe created" }
   else
    render json: { status: 500, message "internal server error" }
  end

  def update
    op = UpdateRecipeOp.new(recipe_params.h)
    op.execute unless op.valid?
    r
  end

  def delete
    @recipe = Recipe.find_by_id(params[:recipe_id])
    if session[:current_user] == @recipe.user_id
      @recipe.destroy!
      render json: { status: 200, message: "Recipe deleted!"}
    else
      render json: { status: 500, message: "Cannot delete another user's recipe"}
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit( 
                    :recipe_id,
                    :recipe_title, 
                    :genre, 
                    :current_user_id,
                    :recipe => {},
                    :instructions => [],
                    :ingredients => [:quantity, :unit_type, :name],
    )
  end
end
