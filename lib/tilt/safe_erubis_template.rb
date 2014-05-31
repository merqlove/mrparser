module Tilt
  module HtmlSafe
    ##
    # Modded ErubisTemplate that doesn't insist in an String as output
    # buffer.
    #
    # @api private
    class SafeErubisTemplate < ErubisTemplate
      def prepare
        @options[:escape] = true
        super
      end
      ##
      # In preamble we need a flag `__in_erb_template` and SafeBuffer for padrino apps.
      #
      def precompiled_preamble(locals)
        original = super
        "__in_erb_template = true\n" << original.rpartition("\n").first << "#{@outvar} = _buf = ActiveSupport::SafeBuffer.new\n"
      end
    end
  end
end
