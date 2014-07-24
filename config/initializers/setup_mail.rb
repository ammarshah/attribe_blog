ActionMailer::Base.smtp_settings = {
  :address              => "localhost",
  :port                 => 25,
  :domain               => "domain",
  :user_name            => "moizahmed@iiee.edu.pk",
  :password             => "moizahmedansari",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
