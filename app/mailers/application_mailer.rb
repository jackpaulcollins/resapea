# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'jack@resapea.io'
  layout 'mailer'
end
