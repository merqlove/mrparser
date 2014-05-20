# ENV['RACK_ENV'] ||= ENV['RAILS_ENV'] ||= 'development'
#
# require 'rubygems'
# require 'bundler/setup'
#
# # Setup load paths
# Bundler.require
# $: << File.expand_path('../', __FILE__)
# $: << File.expand_path('../lib', __FILE__)
#
# require 'dotenv'
# Dotenv.load
#
# # Require base
# require 'sinatra/base'
# require 'sinatra/content_for'
# require 'padrino-helpers'
# require 'padrino-mailer'
# require 'active_support/core_ext/string'
# require 'active_support/core_ext/array'
# require 'active_support/core_ext/hash'
# require 'active_support/json'
#
# libraries = Dir[File.expand_path('../lib/**/*.rb', __FILE__)]
# libraries.each do |path_name|
#   require path_name
# end
#
# require 'i18n/backend/fallbacks'
#
# if ENV['RACK_ENV'] == 'development'
#   require "sinatra/reloader"
# end

require './boot'

libraries = Dir[File.expand_path('../lib/**/*.rb', __FILE__)]
libraries.each do |path_name|
  require path_name
end

I18n.enforce_available_locales = true
CACHE = Dalli::Client.new ["127.0.0.1:11211"]

# Locales
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
I18n.load_path = Dir[File.join('./config/locales/*.yml')]
I18n.backend.load_translations
I18n.config.available_locales = ["ru", "en"]
I18n.config.default_locale = 'ru'
I18n.config.locale = 'ru'

module MrParser

  # Init sub-modules
  module Routes; end
  module Extensions; end
  module Helpers; end
  module Models; end

  %w(extensions models helpers routes).each do |folder|
    Dir["app/#{folder}/*.rb"].sort.each do |file|
      file_path = file.to_s.gsub(/\.rb/, '')
      name = file_path.gsub(/app\/#{folder}\//, '').titlecase.to_sym
      MrParser.const_get(folder.titlecase).autoload name, file_path
    end
  end

  class App < Sinatra::Application
    # use ActiveRecord::ConnectionAdapters::ConnectionManagement
    # use Rack::Cache, verbose: true, metastore: CACHE, entitystore: CACHE

    configure do
      set :database, lambda {
        ENV['DATABASE_URL'] ||
            "postgres://localhost:5432/mr_parser_#{environment}"
      }
    end

    configure :development, :staging do
      database.loggers << Logger.new(STDOUT)
    end

    configure do
      set :root, File.expand_path('../', __FILE__)
      set :views, 'app/views'

      set :erb, escape_html: true

      set :sessions,
          httponly: true,
          secure: production?,
          expire_after: 5.years,
          secret: ENV["SECRET_TOKEN"]

      disable :method_override, :protection, :static
    end

    use Rack::Deflater
    use Rack::Standards

    if settings.development?
      use Routes::Static
    end

    unless settings.production?
      use Routes::Assets
    end

    use Routes::Posts
  end
end

include MrParser::Models