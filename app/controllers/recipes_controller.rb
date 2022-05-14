# frozen_string_literal: true

class RecipesController < ApplicationController
  include VoteConcern
  include RecipeConcern

  def index
    @recipes = Recipe.paginate(page: recipe_params[:page]).order('total_points desc')
    data = RecipeBlueprint.render(@recipes)
    render json: { data: data, page: @recipes.current_page, pages: @recipes.total_pages }
  end

  def show
    if (recipe = Recipe.find_by_id(recipe_params[:id]))
      @recipe = RecipeBlueprint.render(recipe)
      render json: { status: 200, recipe: @recipe }
    else
      render json: { status: 404, message: 'recipe not found.' }
    end
  end

  def query
    if recipe_params[:filter]
      filter = recipe_params[:compatibilities].join(',')
      @recipes = Recipe.paginate(page: recipe_params[:page]).in_query(recipe_params[:query_string]).filter_by_compatibilities(filter).order('total_points desc')
    else
      @recipes = Recipe.paginate(page: recipe_params[:page]).in_query(recipe_params[:query_string]).order('total_points desc')
    end
    data = RecipeBlueprint.render(@recipes)
    render json: { status: 200, data: data, page: @recipes.current_page, pages: @recipes.total_pages }
  end

  def create
    return unless session[:user_id].present?

    @recipe = Recipe.new(recipe_params.except(:picture))
    if @recipe.save
      picture_upload(@recipe, recipe_params[:picture]) if recipe_params[:picture]
      render json: { status: 200, message: 'recipe created' }
    else
      render json: { status: 500, message: 'internal server error', error: @recipe.errors }
    end
  end

  def update
    @recipe = Recipe.find_by_id(recipe_params[:id])
    return unless session[:user_id] == @recipe.user_id

    if @recipe.update(recipe_params.except(:picture))
      picture_update(@recipe, recipe_params[:picture]) if recipe_params[:picture]
      render json: { status: 200, message: 'recipe updated' }
    else
      render json: { status: 500, message: 'internal server error', error: @recipe.errors }
    end
  end

  def destroy_photo
    @recipe = Recipe.find_by_id(recipe_params[:id])
    @recipe.update(photo_url: nil)
    @recipe.picture.purge
    render json: { status: 200, message: 'Photo deleted' }
  end

  def destroy
    @recipe = Recipe.find_by_id(recipe_params[:id])
    return unless user_requesting_own_recipe_resource(@recipe)

    if @recipe.destroy
      render json: { status: 200, message: 'Recipe deleted!' }
    else
      render json: { status: 500, message: 'Internal server error' }
    end
  end

  def destroy_instruction
    @instruction = Instruction.find_by_id(recipe_params[:instruction_id])
    return unless user_requesting_own_recipe_resource(@instruction)

    if @instruction.destroy!
      render json: { status: 200, message: 'Instruction deleted!' }
    else
      render json: { status: 500, message: 'Internal server error' }
    end
  end

  def destroy_ingredient
    @ingredient = RecipeIngredient.find_by_id(recipe_params[:ingredient_id])
    return unless user_requesting_own_recipe_resource(@ingredient)

    if @ingredient.destroy!
      render json: { status: 200, message: 'Ingredient deleted!' }
    else
      render json: { status: 500, message: 'Internal server error' }
    end
  end

  def email_recipe_to_user
    if @current_user
      user = User.find_by_id(recipe_params[:user_id])
      recipe = Recipe.includes(:recipe_ingredients, :instructions).find_by_id(recipe_params[:recipe_id])
      RecipeMailer.email_recipe_to_user(recipe, user).deliver_now
      render json: { status: 200, message: 'email sent' }
    else
      render json: { status: 404, message: 'You need to be logged in for this' }
    end
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
      :filter,
      :page,
      recipe: {},
      compatibilities: [],
      instructions_attributes: %i[id recipe_id content position _destroy],
      recipe_ingredients_attributes: %i[id recipe_id measurement_unit_quantity
                                        measurement_unit_type ingredient_name _destroy]
    )
  end
end
