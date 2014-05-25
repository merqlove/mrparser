require 'rack/csrf'
module MrParser
  module Helpers
    module Security
      def csrf_token
        Rack::Csrf.csrf_token(env)
      end

      def csrf_tag
        Rack::Csrf.csrf_tag(env)
      end

      def csrf_metatag
        Rack::Csrf.csrf_metatag(env)
      end
    end
  end
end