class RecipesController < ApplicationController
  include VoteConcern
  include RecipeConcern

  def index
    @recipes = RecipeBlueprint.render(Recipe.all.order("total_points desc"))
    render json: { data: @recipes }
  end

  def show
    if (recipe = Recipe.find_by_id(recipe_params[:id]))
      @recipe = RecipeBlueprint.render(recipe)
      render json: { status: 200, recipe: @recipe }
    else
      render json: { status: 404, message: "recipe not found." }
    end
  end

  def query
    @recipes = RecipeBlueprint.render(Recipe.where("lower(name) LIKE ? OR lower(genre) LIKE ?", "%#{recipe_params[:query_string].downcase}%","%" + recipe_params[:query_string].downcase + "%"))
    render json: { status: 200, data: @recipes}
  end

  def create
    return unless session[:user_id].present?
    @recipe = Recipe.new(recipe_params.except(:picture))
    if @recipe.save
      picture_upload(@recipe, recipe_params[:pitcure]) if recipe_params[:picture]
      render json: { status: 200, message: "recipe created" }
    else
      render json: { status: 500, message: "internal server error", error: @recipe.errors }
    end
  end

  def update
    @recipe = Recipe.find_by_id(recipe_params[:id])
    return unless session[:user_id] == @recipe.user_id
    if @recipe.update(recipe_params.except(:picture))
      picture_update(@recipe, recipe_params[:pitcure]) if recipe_params[:picture]
      render json: { status: 200, message: "recipe updated" }
    else
      render json: { status: 500, message: "internal server error", error: @recipe.errors }
    end
  end

  def destroy_photo
    @recipe = Recipe.find_by_id(recipe_params[:id])
    @recipe.update(photo_url: nil)
    @recipe.picture.purge
    render json: { status: 200, message: "Photo deleted"}
  end

  def destroy
    @recipe = Recipe.find_by_id(recipe_params[:id])
    return unless user_requesting_own_recipe_resource(@recipe)
    if @recipe.destroy
      render json: { status: 200, message: "Recipe deleted!"}
    else
      render json: { status: 500, message: "Internal server error"}
    end
  end

  def destroy_instruction
    @instruction = Instruction.find_by_id(recipe_params[:instruction_id])
    return unless user_requesting_own_recipe_resource(@instruction)
    if @instruction.destroy!
      render json: { status: 200, message: "Instruction deleted!"}
    else
      render json: { status: 500, message: "Internal server error"}
    end
  end

  def destroy_ingredient
    @ingredient = RecipeIngredient.find_by_id(recipe_params[:ingredient_id])
    return unless user_requesting_own_recipe_resource(@ingredient)
      if @ingredient.destroy!
        render json: { status: 200, message: "Ingredient deleted!"}
      else
        render json: { status: 500, message: "Internal server error"}
      end
  end

  def email_recipe_to_user
    user = User.find_by_id(recipe_params[:user_id])
    recipe = Recipe.includes(:recipe_ingredients, :instructions).find_by_id(recipe_params[:recipe_id])
    RecipeMailer.email_recipe_to_user(recipe, user).deliver_now
    render json: { status: 200, message: "email sent"}
  end

  private

  def recipe_params
    params.require(:recipe).permit( 
                    :id,
                    :recipe_id,
                    :name, 
                    :genre,
                    :cuisine,
                    :user_id,
                    :instruction_id,
                    :ingredient_id,
                    :query_string,
                    :picture,
                    :recipe => {},
                    :compatibilities => [],
                    :instructions_attributes => [:id, :recipe_id, :content, :position, :_destroy],
                    :recipe_ingredients_attributes => [:id, :recipe_id, :measurement_unit_quantity, :measurement_unit_type, :ingredient_name, :_destroy],
    )
  end
end
