# frozen_string_literal: true

class UsersController < ApplicationController
  include CurrentUserConcern
  def show
    @user = User.find_by_id(user_params[:user_id])
    @recipes = Recipe.paginate(page: user_params[:page]).where(user_id: @user.id)
    if user_requesting_own_resource(@user)
      render json: {
        status: 200,
        data: {
          user: @user,
          recipes: RecipeBlueprint.render(@recipes),
          page: @recipes.current_page,
          pages: @recipes.total_pages
        }
      }
    else
      # if someone else is requesting, only send username
      render json: {
        status: 200,
        data: {
          user: { username: @user.username },
          recipes: RecipeBlueprint.render(@recipes),
          page: @recipes.current_page,
          pages: @recipes.total_pages
        }
      }
    end
  end

  def update
    @user = User.find_by_id(session[:user_id])
    if @user.update(user_params)
      render json: { status: 200, user: @user }
    else
      render json: { status: 500, errors: @user.errors.full_messages }
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :user_id,
      :page,
      :username,
      :email
    )
  end
end
