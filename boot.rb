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
# i18n/backend/fallbacks
# active_support/json
%w(
sinatra/base
sinatra/content_for
sinatra/respond_to
padrino-helpers
padrino-mailer
active_support/core_ext/string
active_support/core_ext/array
active_support/core_ext/hash
i18n/backend/fallbacks
yaml
).each { |d| require d }

config = YAML.load(File.read(File.expand_path('../config/application.yml', __FILE__)))
config.merge! config.fetch($env, {})
config.each do |key, value|
  ENV[key] = value.to_s unless value.kind_of? Hash
end

if $env == 'development'
  require "sinatra/reloader"
end
