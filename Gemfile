source 'https://rubygems.org'

# UTF-8 fix
if RUBY_VERSION =~ /2.1/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

gem 'puma'
gem 'rake'

gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib', require: false

# Sinatra Addons
# gem "sinatra-respond_to"

# Padrino Modules
# gem "padrino-core", "~> 0.12.2", require: "padrino-core/application/routing"
gem "padrino-helpers", "~> 0.12.2"
gem "padrino-mailer", "~> 0.12.2"

# Rack::Standards adds IE X-UA-Compatible headers for Rack applications.
gem 'rack-standards'

gem 'rack-cache', require: "rack/cache"
gem 'rack-flash3', require: "rack/flash"

gem 'erubis'
gem 'i18n'
gem 'activesupport', require: false

gem 'builder'
gem 'json', '~> 1.7.7'

gem 'sprockets'

# Assets
group :assets do
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

# DB
gem 'pg'
gem 'sequel'
gem 'sinatra-sequel'

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