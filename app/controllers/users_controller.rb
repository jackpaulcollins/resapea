class UsersController < ApplicationController
  include CurrentUserConcern
  def show
    @user = User.find_by_id(user_params[:user_id])
    # check if the logged in user is requesting their own data
    if @user = @current_user
      render json: { 
                    status: 200,
                    data: { user: @user, recipes: RecipeBlueprint.render(Recipe.where(user_id: @user.id)) }
                    }
    else
      # if someone else is requesting, only send safe response
      render json: { data: { user: { user_name: @user.user_name, 
                                     recipes: RecipeBlueprint.render(Recipe.where(user_id: @user.id)) }}}
    end
  end

  private
    def user_params
      params.require(:user).permit(
                      :user_id
                    )
    end
end