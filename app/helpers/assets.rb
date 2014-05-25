module MrParser
  module Helpers
    module Assets extend self
      class UnknownAsset < StandardError; end

      module Helpers
        APPEND_ASSET_EXTENSIONS = ["js", "css"]
        ABSOLUTE_URL_PATTERN = %r{^(https?://)}
        ASSET_FOLDERS = {
            :js => 'javascripts',
            :css => 'stylesheets',
            :fonts => 'fonts',
            :images => 'images',
        }

        ##
        # Returns the path to the specified asset (css or javascript).
        #
        # @param [String] kind
        #   The kind of asset (i.e :images, :js, :css).
        # @param [String] source
        #   The path to the asset (relative or absolute).
        #
        # @return [String] Path for the asset given the +kind+ and +source+.
        #
        # @example
        #   # Generates: /javascripts/application.js?1269008689
        #   asset_path :js, :application
        #
        #   # Generates: /stylesheets/application.css?1269008689
        #   asset_path :css, :application
        #
        #   # Generates: /images/example.jpg?1269008689
        #   asset_path :images, 'example.jpg'
        #
        #   # Generates: /uploads/file.ext?1269008689
        #   asset_path 'uploads/file.ext'
        #
        def asset_path(kind, source = nil)
          kind, source = source, kind if source.nil?
          source = asset_normalize_extension(kind, URI.escape(source.to_s))
          return source if source =~ ABSOLUTE_URL_PATTERN || source =~ /^\//
          source = File.join(asset_folder_name(kind), source)
          timestamp = asset_timestamp(source)
          result_path = uri_root_path(source)
          "#{result_path}#{timestamp}"
        end
      end

      def self.registered(app)
        app.helpers Helpers
      end
    end
  end
end