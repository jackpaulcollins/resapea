class RegistrationsController < ApplicationController
  def create
    debugger
    @user = User.new(registration_params)

    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      session[:user_id] = @user.id
      render json: {
        status: :created,
        user: @user
      }
    else
      render json: { status: 422, errors: @user.errors.full_messages }
    end
  end

  private

    def registration_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation, :user => {})
    end
end