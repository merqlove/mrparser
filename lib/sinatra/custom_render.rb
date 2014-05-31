module Sinatra
  module CustomRender
    module SafeTemplate
      def render(*)
        super.html_safe
      end
    end

    module Helpers
      def render(*args, &block)
        @_out_buf,  buf_was = ActiveSupport::SafeBuffer.new, @_out_buf
        super *args, &block
      ensure
        @_out_buf = buf_was
      end
      private :render
    end

    def self.registered(app)
      app.helpers Helpers
    end
  end
end