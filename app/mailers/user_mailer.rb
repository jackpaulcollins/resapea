# frozen_string_literal: true

class UserMailer < ActionMailer::Base
  default from: 'jack@respea.io'
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Resapea!')
  end

  def reset_password(user)
    @user = user
    @token = @user.reset_password_token
    mail(to: @user.email, subject: 'Reset Your Password')
  end
end
