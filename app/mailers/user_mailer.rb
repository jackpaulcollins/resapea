class UserMailer < ActionMailer::Base
  require "faraday"
  require 'uri'

  def welcome_email(user)
    @user = user
    params = {
      api_key => ENV['SMTP_KEY'],
      to => [@user],
      sender => "jack@resapea.io",
      subject => "Hello Beautifu",
      text_body => "You're my favorite person ever",
      html_body => "<h1>You're my favorite person ever</h1>",
  }
    encoded_params = URI.encode_www_form(params)
    response = Faraday.post("https://api.smtp2go.com/v3/email/send", encoded_params)
    response.body if response.status == 201
  end
end