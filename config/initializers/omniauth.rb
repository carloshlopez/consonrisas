Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'qfol8pqa9RUjJ6tR9p8fw', '70cxEdyf6FwhAHL3XUoyUXPd6dKsFxCUghWkpiiM'
  provider :facebook, '161667273881845', 'a90fc797ce1572a3e4952b4d8172f228',{:scope => 'publish_stream,email, offline_access', :client_options => {:ssl =>
{:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}
end

Twitter.configure do |config|
  config.consumer_key = 'qfol8pqa9RUjJ6tR9p8fw'
  config.consumer_secret = '70cxEdyf6FwhAHL3XUoyUXPd6dKsFxCUghWkpiiM'
  config.oauth_token = '48552466-3LPQJ4poPvDSswEXXPAcQoiVOhkGmvJ5rLc6Kd8EE'
  config.oauth_token_secret = 'XXsbLpRwYtZZdstb7TyxnaarXxKacPCeGuY1NTO8ew'
end
