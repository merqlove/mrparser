source 'https://rubygems.org'

# UTF-8 fix
if RUBY_VERSION =~ /2.1/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

gem 'puma'
gem 'rake'

gem 'sinatra', require: 'sinatra/base'

# Sinatra Addons
gem 'sinatra-contrib', require: false
gem 'sinatra-respond_to', require: false
gem 'yandex_captcha', require: false, github: 'merqlove/yandex-captcha'

# Padrino Modules
# gem "padrino-core", "~> 0.12.2", require: "padrino-core/application/routing", github: 'merqlove/padrino-framework'
gem "padrino-helpers", "~> 0.12.2", require: false, github: 'merqlove/padrino-framework'
gem "padrino-mailer", "~> 0.12.2", require: false, github: 'merqlove/padrino-framework'

# Rack::Standards adds IE X-UA-Compatible headers for Rack applications.
gem 'rack-standards'

gem 'rack-cache', require: "rack/cache"
gem 'rack-flash3', require: "rack/flash"

gem 'erubis'
gem 'i18n'
gem 'activesupport', require: false

gem 'builder'
gem 'json', '~> 1.7.7'


# Assets
group :assets do
  gem 'sprockets'

  gem 'sass', '~> 3.2.19'
  gem 'compass'
  gem 'uglifier'
  gem 'closure-compiler'
  gem 'coffee-script'
  # gem 'compass-sourcemaps', require: false
  gem 'sprockets-sass'
  gem 'sprockets-memcache-store'
  gem 'eco'
  gem 'yui-compressor'
end

gem 'dalli'
gem 'memcachier'
gem 'kgio'
gem 'airbrake', require: false

# DB
gem 'pg'
gem 'sequel'
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