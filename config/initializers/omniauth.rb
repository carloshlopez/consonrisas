Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'qfol8pqa9RUjJ6tR9p8fw', '70cxEdyf6FwhAHL3XUoyUXPd6dKsFxCUghWkpiiM'
  provider :facebook, '161667273881845', 'a90fc797ce1572a3e4952b4d8172f228'
end
