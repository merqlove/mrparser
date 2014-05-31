module Sinatra
  module Capture
    def capture_html(*args, &block)
      capture(*args, &block).html_safe
    end
  end
end