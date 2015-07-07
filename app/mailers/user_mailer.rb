require 'rest_client'

class UserMailer < ApplicationMailer
  default from: "andrew@ampletorque.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #

  API_KEY = ""
  API_URL = "https://api:#{API_KEY}@api.mailgun.net/v3/sandboxafb609c0e1ae43c5bd693b6f41cf60e0.mailgun.org"

  def signup_confirmation(user)

    @greeting = "Hi"
    @user = user

    RestClient.post API_URL+"/messages",
    :from => "postmaster@sandboxafb609c0e1ae43c5bd693b6f41cf60e0.mailgun.org",
    # :from => "andrew@ampletorque.com",
    :to => @user.email,
    :subject => "Howdy again, #{@user.email}",
    :text => "You're our newest user, #{@user.email}!",
    :html => "You're our newest user, <b>#{@user.email}</b>!"

    # mail to: user.email, subject: "Sign Up Confirmation"
  end
end
