require 'iron_worker'

IronWorker.configure do |config|
  config.token = 'tSNJz33ZkkKdBWvUhvYBNIEmhbQ'
  config.project_id = '4ed7ace3b786c80144000060'
end
Consonrisas::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true
#  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.default_url_options = { :host => 'www.conectandosonrisas.org' }
  
  Rails.application.routes.default_url_options[:host]= 'www.conectandosonrisas.org'
  
ActionMailer::Base.smtp_settings = {
:user_name => "carloshlopez@gmail.com",
:password => "usuario123",
:domain => "www.conectandosonrisas.org",
:address => "smtp.sendgrid.net",
:port => 587,
:authentication => :plain,
:enable_starttls_auto => true
}

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
#  config.load_paths += %W( #{RAILS_ROOT}/app/workers )

  config.autoload_paths += %W( #{::Rails.root.to_s}/app/workers )

  config.fb.page_id = ENV['FB_PAGE_ID'] || '530935246927411'
  config.fb.auth_token = ENV['FB_AUTH_TOKEN'] || 'AAACTCRhuePUBAECO7LiGoPu1qXiIasQjHcZCpAWdQBT1mZCOU2SZCcV4OBbGSbLLbAZCilZBIonnUZCnh5EpAhHORToNCCcyTurD2WZAaFitZCqWZCwIRXjeO'

  config.twitter.consumer_key = ENV['TWITTER_CONSUMER_KEY'] || 'bO99GGfXFk2El5vBijNDQ'
  config.twitter.consumer_secret = ENV['TWITTER_CONSUMER_SECRET'] || 'JjWmNG4UvoyA1ahNyuTXiuNWzCGmdHvdPM5SCfuiWI'
  config.twitter.oauth_token = ENV['TWITTER_OAUTH_TOKEN'] || '178876518-vlczga9RaNBuwACrSLzCduh2wZbT5LYadKt3qiQ2'
  config.twitter.oauth_secret = ENV['TWITTER_OAUTH_SECRET'] || 'POvjVYCStZShkbigRKHwlLZ3lhoOo6LxXWQ4F2yNK0'

end

