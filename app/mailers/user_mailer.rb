class UserMailer < ActionMailer::Base
  default from: "jack@respea.io"
  def welcome_email(user)
      @user = user
      mail(to: @user.email, subject: 'Welcome to Resapea!')
    end
  end