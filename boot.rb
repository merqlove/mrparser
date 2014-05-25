ENV['RACK_ENV'] ||= ENV['RAILS_ENV'] ||= 'development'

require 'rubygems'
require 'bundler/setup'

# # Setup load paths
$env = ENV['RACK_ENV']
Bundler.require :default, $env.to_sym
$: << File.expand_path('../', __FILE__)
$: << File.expand_path('../lib', __FILE__)

# rake
# puma
# rack/standards
# rack/cache
# rack/flash
# erubis
# builder
# json
# i18n
# padrino-helpers/form_helpers
# padrino-helpers/breadcrumb_helpers
# padrino-helpers/format_helpers
# padrino-helpers/number_helpers
# padrino-helpers/output_helpers
# padrino-helpers/translation_helpers
%w(
sequel/extensions/pagination
sinatra/sequel
sinatra/content_for
sinatra/respond_to
yandex_captcha
padrino-helpers/asset_tag_helpers
padrino-mailer
active_support/core_ext/string
active_support/core_ext/array
active_support/core_ext/hash
active_support/json
active_support/dependencies/autoload
active_support/time_with_zone
active_support/core_ext/string/conversions
active_support/core_ext/object/with_options
active_support/option_merger
active_support/inflector
active_support/core_ext/hash/except
i18n/backend/fallbacks
yaml
).each { |d| require d }

def config_load_source(path)
  return nil unless path
  config = YAML.load(File.read(File.expand_path(path, __FILE__)))
  config.merge! config.fetch($env, {})
end

config = config_load_source '../config/application.yml'
config.each { |key, value| ENV[key] = value.to_s unless value.kind_of? Hash }

DB_CONFIG = config_load_source '../config/database.yml'
DB_CONFIG.symbolize_keys!

if $env == 'development'
  require 'sinatra/reloader'
end

if $env == 'production'
  require 'airbrake'
end
