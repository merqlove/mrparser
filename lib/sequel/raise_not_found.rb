require 'sequel'

module Sequel
  module Plugins
    # The RailsExtensions plugin adds a single class method to Sequel::Model in
    # order to make its use in controllers a little more like ActiveRecord's.
    # The +find!+ method is added which will raise an exception if no object is
    # found. By adding the following code to a Railtie:
    #
    #   config.action_dispatch.rescue_responses.merge!(
    #    'Sequel::Plugins::RailsExtensions::ModelNotFound' => :not_found
    #   )
    #
    # Usage:
    #
    #   # Apply plugin to all models:
    #   Sequel::Model.plugin :raise_not_found
    #
    #   # Apply plugin to a single model:
    #   Album.plugin :raise_not_found
    module RaiseNotFound
      class ModelNotFound < Sequel::Error
      end

      module ClassMethods
        def find!(args)
          m = self[args]
          fail ModelNotFound, "Couldn't find #{self} matching #{args}." unless m
          m
        end
      end
    end
  end
end