class UserMailer < ActionMailer::Base
  default from: "moizahmed@iiee.edu.pk"
  def registration_confirmation(user)
    @user = user
    mail(to: @user.email, subject: "registered")
  end
end
