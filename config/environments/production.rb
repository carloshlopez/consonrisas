require 'iron_worker'

IronWorker.configure do |config|
  config.token = 'tSNJz33ZkkKdBWvUhvYBNIEmhbQ'
  config.project_id = '4ed7ace3b786c80144000060'
end

Consonrisas::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # For nginx:
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = false

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { :host => 'www.conectandosonrisas.org' }
  # config.action_mailer.raise_delivery_errors = true

  Rails.application.routes.default_url_options[:host]= 'www.conectandosonrisas.org'
  # ActionMailer::Base.smtp_settings = {
  #   :enable_starttls_auto => true,
  #   :address => "smtp.gmail.com",
  #   :port => 587,
  #   :domain => "www.conectandosonrisas.org",
  #   :authentication => :plain,
  #   :user_name => "noreply@conectandosonrisas.org",
  #   :password => "1qaz2wsx"
  # }


  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  config.fb.page_id = ENV['FB_PAGE_ID'] || '207633962587548'
  config.fb.auth_token = ENV['FB_AUTH_TOKEN'] || 'AAACTCRhuePUBAGW0okACn6o5nQjueWh3Ibwd3QeglNFM97iMeiQrOC4S7wJ7s7yA8JnwehH3jaBZAI0f08YkngMOjTkGzGrsZC8LZC5fn16niobwMkd'

  config.twitter.consumer_key = ENV['TWITTER_CONSUMER_KEY'] || 'nwNIvpozXZQr4urfsB2J7akSN'
  config.twitter.consumer_secret = ENV['TWITTER_CONSUMER_SECRET'] || 'Na7DqkIu8AmBYaZAgNtbt5YZtlb9GxlXp8JmxkQtnxvSbITroM'
  config.twitter.oauth_token = ENV['TWITTER_OAUTH_TOKEN'] || '266237442-k39svyWfUeeymDXXDcmSf1oUVOWQ4Cldfq35MFVo'
  config.twitter.oauth_secret = ENV['TWITTER_OAUTH_SECRET'] || 'UB71ssUD2gLLf13CKjJjEGB7sDCIntFHSHbee86Gn5fHF'
end
