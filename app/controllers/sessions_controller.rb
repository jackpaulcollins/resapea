class SessionsController < ApplicationController
  include CurrentUserConcern

  def create
    user = User
            .find_by(email: session_params[:email])
            .try(:authenticate, session_params[:password])

    if user
      session[:user_id] = user.id
      session_params[:remember_me] ? remember(user) : forget(user)
      
      render json: {
        status: :created,
        logged_in: true,
        user: user
      }
    else
      render json: { status: 401,
                     message: 'Password incorrect' }
    end
  end

  def logout
    reset_session
    render json: { status: 200, logged_out: true }
  end

  private

    def session_params
      params.require(:user).permit(:email, :password, :remember_me, :user => {})
    end
end