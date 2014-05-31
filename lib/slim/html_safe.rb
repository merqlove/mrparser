module Slim
  module HtmlSafe
    class SlimTemplate < Template
      include Sinatra::CustomRender::SafeTemplate

      def precompiled_preamble(locals)
        "__in_slim_template = true\n" << super
      end
    end
  end
end