class PasswordsController < ApplicationController
  def forgot
    if params[:email].blank?
      return render json: { 
                      status: 422,
                      message: 'Email must be given'
                   }
    end

    @user = User.find_by(email: params[:email]) 

    if @user.present?
      @user.generate_password_token!
      UserMailer.reset_password(@user).deliver_now

      render json: {
                      status: 200,
                      message: 'Password Reset Email Sent!' 
                   }
    else
      render json: {
                      status: 500,
                      message: 'Email address not found.'
                   }
    end
  end

  def reset
    token = params[:token].to_s

    if params[:token].blank?
      return render json: {
                            status: 500,
                            error: 'Reset token not present'
                          }
    end

    user = User.find_by(reset_password_token: token)

    if user.present? && user.password_token_valid?
      # TODO don't let users use an old password
      if user.reset_password!(params[:password])
        render json: {
                        status: 200,
                        message: 'Your password has been reset.'
                     }
      
        #set the token to nil
        user.reset_password_token = nil
        user.save!
      else
        render json: {
                        status: 422,
                        message: user.errors.full_messages
                     }
      end
    else
      render json: {
                      status: 500,
                      message: 'Link invalid or expired.'
                   }
    end
  end
end