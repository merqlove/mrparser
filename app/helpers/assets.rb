module MrParser
  module Helpers
    module Assets extend self
      class UnknownAsset < StandardError; end

      module Helpers
        def asset_path(name)
          asset = settings.assets[name]
          raise UnknownAsset, "Unknown asset: #{name}" unless asset
          "#{settings.asset_host}/assets/#{asset.digest_path}"
        end
      end

      def self.registered(app)
        app.helpers Helpers
      end
    end
  end
end