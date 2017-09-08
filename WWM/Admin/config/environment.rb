# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
NewKreatioCMS::Application.initialize!

   ActionMailer::Base.smtp_settings = {
     :address              => "127.0.0.1",
     :port                 => 25,
     :domain               => "dev.themachinist.kreatio.com",
     :enable_starttls_auto => false
    }
