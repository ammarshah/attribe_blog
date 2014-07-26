class UserMailer < ActionMailer::Base
  default :from => "wallchalkingat@gmail.com"
  
  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Registered")
  end

  def comment_notification(email)
   
    mail(:to => email, :subject => "Comment")

  end

end
