Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Consonrisas::Application.config.twitter.consumer_key, Consonrisas::Application.config.twitter.consumer_secret
  provider :facebook, '161667273881845', 'a90fc797ce1572a3e4952b4d8172f228', {:scope => 'publish_stream,email, offline_access, manage_pages', :client_options => {:ssl =>
{:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}
end

Twitter.configure do |config|
  config.consumer_key = Consonrisas::Application.config.twitter.consumer_key
  config.consumer_secret = Consonrisas::Application.config.twitter.consumer_secret
  config.oauth_token = Consonrisas::Application.config.twitter.oauth_token
  config.oauth_token_secret = Consonrisas::Application.config.twitter.oauth_secret
end
