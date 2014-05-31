source 'https://rubygems.org'

# UTF-8 fix
if RUBY_VERSION =~ /2.1/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

gem 'rake'
gem 'puma'

platforms :ruby, :rbx do
  gem 'pg'
  gem 'kgio'
end

# DB
platform :jruby do
  gem 'jdbc-postgres'
end

gem 'erubis'
gem 'slim'
gem 'i18n'
gem 'tilt-jbuilder', ">= 0.5.0", require: false
gem 'hashie'

gem 'builder'
gem 'json', '~> 1.8.1'
gem 'mail'
gem 'dedent'

gem 'dalli'
gem 'memcachier'
gem 'airbrake', require: false

gem 'will_paginate', require: false

gem 'sinatra', require: 'sinatra/base'

# Sinatra Addons
gem 'sinatra-contrib', require: false
gem 'yandex_captcha', require: false, github: 'merqlove/yandex-captcha'

# Padrino Modules
gem "padrino-helpers", "~> 0.12.2", require: false, github: 'merqlove/padrino-framework'

# Rack::Standards adds IE X-UA-Compatible headers for Rack applications.
gem 'rack-standards'
gem 'rack-cache', require: "rack/cache"
gem 'rack-flash3', require: "rack/flash"
gem 'rack_csrf', require: "rack/csrf"
gem 'encrypted_cookie', require: 'encrypted_cookie'
# gem 'rack-cors', require: 'rack/cors'

# gem 'mustermann', require: false
gem 'activesupport', require: false


# Assets
group :assets do
  gem 'sprockets'

  gem 'sass', '~> 3.2.19'
  gem 'compass'
  gem 'uglifier'
  gem 'closure-compiler'
  gem 'coffee-script'
  gem 'sprockets-sass'
  gem 'sprockets-memcache-store'
  gem 'eco'
  gem 'yui-compressor'
end

gem 'sequel'
gem 'sequel_pg', require: false
gem 'sequel-postgres-schemata', require: false
gem 'sinatra-sequel', require: false, github: 'merqlove/sinatra-sequel'
gem 'sequel_postgresql_triggers'

group :development do
  # gem 'debugger', require: 'ruby-debug'
  gem "brice", require: false
  gem "wirble", require: false
  gem "what_methods", require: false
  gem "awesome_print", require: false
  gem "hirb", require: false
end

group :test do
  # gem 'capybara', '~> 2.2'
  # gem 'rspec', '~> 2.14'
end