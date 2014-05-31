require 'rack/csrf'
module MrParser
  module Helpers
    module Security
      def csrf_token
        Rack::Csrf.csrf_token(env)
      end

      def csrf_tag
        Rack::Csrf.csrf_tag(env).html_safe
      end
      alias :csrf_token_field :csrf_tag

      def csrf_metatag
        Rack::Csrf.csrf_metatag(env).html_safe
      end

      def get_subdomain
        request.subdomain.sub(/\.stage/, '')
      end
    end
  end
end