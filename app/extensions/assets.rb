module MrParser
  module Extensions
    module Assets extend self
      class UnknownAsset < StandardError; end

      module Helpers
        def asset_path(name)
          asset = settings.assets[name]
          raise UnknownAsset, "Unknown asset: #{name}" unless asset
          "#{settings.asset_host}/assets/#{asset.digest_path}"
        end
      end

      def registered(app)
        # Assets
        app.set :assets, assets = Sprockets::Environment.new(app.settings.root)
        app.set :assets_paths, %w{fonts images javascripts stylesheets}
        app.set :assets_compress, app.development? ? false : true

        app.assets_paths.each do |path|
          assets.append_path File.join(app.root, 'app', 'assets', path)
          assets.append_path File.join(app.root, 'vendor', 'assets', path)
        end

        app.set :asset_host, ''

        if Compass
          Compass.add_project_configuration(File.join(app.settings.root, 'config', 'compass.rb'))
        end

        app.configure :development do
          if Sprockets.const_defined?('Sass')
            Sprockets::Sass.options = {
                syntax: :scss,
                style: :expanded,
                line_comments: true
            }
          end
          assets.cache = Sprockets::Cache::FileStore.new('./tmp')
        end

        app.configure :production do
          if Sprockets::Cache.const_defined?('MemcacheStore')
            assets.cache          = Sprockets::Cache::MemcacheStore.new
          end
          if Closure
            assets.js_compressor  = Closure::Compiler.new
          end
          if YUI
            assets.css_compressor = YUI::CssCompressor.new
          end
        end

        if Sprockets.const_defined?('Sass')
          Sprockets::Sass.options[:cache] = false
          Sprockets::Sass.options[:read_cache] = false
        end

        # app.helpers Helpers
      end
    end
  end
end