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
[
'sequel/extensions/pagination',
'sequel/extensions/postgres_schemata',
'sinatra/sequel',
'will_paginate',
'will_paginate/sequel',
'sinatra/content_for',
'sinatra/capture',
'sinatra/jbuilder',
# 'mustermann', # not works in jruby/rbx
'yandex_captcha',
'active_support/core_ext/string',
'active_support/core_ext/array',
'active_support/core_ext/hash',
'active_support/core_ext/hash/indifferent_access',
'active_support/core_ext/string/conversions',
'active_support/core_ext/object/with_options',
'active_support/core_ext/hash/except',
'active_support/core_ext/string/output_safety',
'active_support/core_ext/module/aliasing',
'active_support/core_ext/object/blank',
'active_support/core_ext/array/extract_options',
'active_support/dependencies/autoload',
'active_support/json',
'active_support/time_with_zone',
'active_support/option_merger',
'active_support/inflector',
'padrino-helpers/translation_helpers',
# 'padrino-helpers/output_helpers',
'padrino-helpers/tag_helpers',
'padrino-helpers/format_helpers',
'padrino-helpers/asset_tag_helpers',
'padrino-helpers/form_helpers',
# 'padrino-helpers/form_builder/abstract_form_builder',
# 'padrino-helpers/form_builder/deprecated_builder_methods',
# 'padrino-helpers/form_builder/standard_form_builder',
'padrino-helpers/form_helpers/errors',
'padrino-helpers/form_helpers/options',
# 'padrino-helpers/form_helpers/security',
# 'padrino-helpers/output_helpers/abstract_handler',
# 'padrino-helpers/output_helpers/erb_handler',
# 'padrino-helpers/output_helpers/haml_handler',
# 'padrino-helpers/output_helpers/slim_handler',
# 'lib/sinatra/custom_render', # tilt template dependency
'i18n/backend/fallbacks',
'yaml'
].each { |d| require d }

def config_load_source(path)
  return nil unless path
  template = ERB.new File.read(File.expand_path(path, __FILE__))
  config = YAML.load template.result(binding)
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
