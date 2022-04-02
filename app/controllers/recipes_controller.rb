class RecipesController < ApplicationController

  def index
    @recipes = RecipeBlueprint.render(Recipe.all)

    render json: { data: @recipes }
  end

  def show
    @recipe = RecipeBlueprint.render(Recipe.find_by_id(params[:id]))
    render json: { status: 200, recipe: @recipe}
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      render json: { status: 200, message: "recipe created" }
    else
      render json: { status: 500, message: "internal server error", error: @recipe.errors }
    end
  end

  def update
    @recipe = Recipe.find_by_id(recipe_params[:id])
    return unless session[:user_id] == @recipe.user_id
    if @recipe.update(recipe_params)
      render json: { status: 200, message: "recipe updated", recipe: RecipeBlueprint.render(@recipe) }
    else
      render json: { status: 500, message: "internal server error", error: @recipe.errors }
    end
  end

  def destroy
    @recipe = Recipe.find_by_id(recipe_params[:id])
    if session[:user_id] == @recipe.user_id
      @recipe.destroy!
      render json: { status: 200, message: "Recipe deleted!"}
    else
      render json: { status: 500, message: "Internal server error"}
    end
  end

  def destroy_instruction
    @instruction = Instruction.find_by_id(recipe_params[:instruction_id])
    if @instruction.destroy!
      render json: { status: 200, message: "Instruction deleted!"}
    else
      render json: { status: 500, message: "Internal server error"}
    end
  end

  def destroy_ingredient
    @ingredient = RecipeIngredient.find_by_id(recipe_params[:ingredient_id])
      if @ingredient.destroy!
        render json: { status: 200, message: "Ingredient deleted!"}
      else
        render json: { status: 500, message: "Internal server error"}
      end
  end

  private

  def recipe_params
    params.require(:recipe).permit( 
                    :id,
                    :recipe_id,
                    :name, 
                    :genre, 
                    :user_id,
                    :instruction_id,
                    :ingredient_id,
                    :recipe => {},
                    :instructions_attributes => [:id, :recipe_id, :content, :position, :_destroy],
                    :recipe_ingredients_attributes => [:id, :recipe_id, :measurement_unit_quantity, :measurement_unit_type, :ingredient_name, :_destroy],
    )
  end
end

# pacMakaveli90@gmail.com
