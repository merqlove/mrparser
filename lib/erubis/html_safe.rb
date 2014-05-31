#
# Tim Craft
# http://github.com/timcraft
#
# Alexander Merkulov
# http://github.com/merqlove
#

module Erubis
  module HtmlSafe
    class EscapedEruby < Eruby
      # include Sinatra::CustomRender::SafeTemplate
      include EscapeEnhancer

      # def add_stmt(src, code)
      #   code = code.sub('end', 'nil;end') if code =~ /\A\s*end\s*\Z/
      #   src << code
      #   src << ';' unless code[-1] == ?\n
      # end

      # BLOCK_EXPR = /\s+(do|\{)(\s*\|[^|]*\|)?\s*\Z/
      #
      # def add_expr_literal(src, code)
      #   if code =~ BLOCK_EXPR
      #     src << " #{@bufvar}.concat" << code
      #   else
      #     src << " #{@bufvar}.concat((" << code << ').to_s);'
      #   end
      # end
      #
      # def add_expr_escaped(src, code)
      #   if code =~ BLOCK_EXPR
      #     src << " #{@bufvar}.safe_concat " << code
      #   else
      #     src << " #{@bufvar}.safe_concat " << code << ';'
      #   end
      # end

      # def add_expr_literal(src, code)
      #   src << " #{@bufvar}.concat((" << code << ').to_s);'
      # end
      #
      # def add_expr_escaped(src, code)
      #   src << " #{@bufvar}.safe_concat " << code << ';'
      # end
      #
      # def add_text(src, text)
      #   return if text.empty?
      #   src << " #{@bufvar}.safe_concat('" << escape_text(text) << "');"
      # end

      # def add_expr_literal(src, code)
      #   src << " #{@bufvar} << ::Erubis::HtmlSafe.safe_escape(#{code});"
      # end
      #
      def add_expr_escaped(src, code)
        src << " #{@bufvar} << ::Erubis::HtmlSafe.safe_escape(#{code});"
      end
    end

    def self.safe_escape(object)
      html_safe?(object) ? object.to_s : escape(object)
    end

    def self.html_safe?(object)
      object.respond_to?(:html_safe?) && object.html_safe?
    end

    def self.escape(input)
      Erubis::XmlHelper.escape_xml(input)
    end
  end
end