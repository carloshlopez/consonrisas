class MailEventCreatedWorker < IronWorker::Base

  merge_gem 'actionmailer',{:require=>'action_mailer'}
  merge_mailer '../mailers/event_invitation'

  attr_accessor :subject, :message, :event_name, :event_url, :to
  def run
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      :address => "smtp.sendgrid.net",
      :port => '25',
      :domain => "conectandosonrisas.org",
      :authentication => :plain,
      :user_name => "app366774@heroku.com",
      :password => "94418ccb8c1b86975f"
     }
    EventInvitation.event_created_async(subject, message, event_name, event_url, to).deliver!
  end

end
