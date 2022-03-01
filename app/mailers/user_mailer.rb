class UserMailer < ActionMailer::Base
  default from: "jack@resapea.io"
  def welcome_email(user)
      @user = user
      mail(to: @user.email, subject: 'Welcome to Resapea!')
    end
  end