module MrParser
  module Routes
    class Assets < Static
      get '/assets/*' do
        env['PATH_INFO'].sub!(%r{^/assets}, '')
        settings.assets.call(env)
      end
    end
  end
end