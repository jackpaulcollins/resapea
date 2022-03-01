class RegistrationsController < ApplicationController
  def create
    @user = User.new(
      email: params['user']['email'],
      username: params['user']['username'],
      password: params['user']['password'],
      password_confirmation: params['user']['password_confirmation']
    )

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
end