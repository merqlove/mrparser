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
# yaml
# active_support/json
# dotenv
%w(
sinatra/base
sinatra/content_for
padrino-helpers
padrino-mailer
active_support/core_ext/string
active_support/core_ext/array
active_support/core_ext/hash
i18n/backend/fallbacks
).each { |d| require d }

# Dotenv.load

if $env == 'development'
  require "sinatra/reloader"
end
