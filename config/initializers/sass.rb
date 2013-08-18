# IF YOU WANT TO REGENERATE DE CSS IN HEROKU USE THIS:
#Sass::Plugin.options.merge!(
#  :template_location => 'public/stylesheets/sass',
#  :css_location => 'tmp/stylesheets'
#)

#Rails.configuration.middleware.delete('Sass::Plugin::Rack')
#Rails.configuration.middleware.insert_before('Rack::Sendfile', 'Sass::Plugin::Rack')

#Rails.configuration.middleware.insert_before('Rack::Sendfile', 'Rack::Static',
#    :urls => ['/stylesheets'],
#    :root => "#{Rails.root}/tmp")

#IF YOU PUT THE GENERATED CSS ON THE DEFAULT LOCATION, UNCOMMENT THIS LINE WHEN UPLOADED TO HEROKU
require 'sass/plugin'
Sass::Plugin.options[:never_update] = true
