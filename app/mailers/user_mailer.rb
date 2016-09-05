class UserMailer < ActionMailer::Base
  default from: "donotreply@example.com"

  def registration_confirmation(user, password)
    @user = user
    @password = password
    @url  = "http://app.saralanalytics.com"
    mail(:to=>user.email, :subject=>"Registered Successfully")
  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end
