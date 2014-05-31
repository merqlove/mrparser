module MrParser
  module Helpers
    module Output
      def submit(*args)
        csrf_tag << submit_tag(*args)
      end

      def concat_content(text="")
        text
      end

      def content_tag(name, content = nil, options = nil, &block)
        if block_given?
          options = content if content.is_a?(Hash)
          content = capture_html(&block)
        end

        options    = parse_data_options(name, options)
        attributes = tag_attributes(options)
        output = ActiveSupport::SafeBuffer.new
        output.safe_concat "<#{name}#{attributes}>"
        if content.respond_to?(:each) && !content.is_a?(String)
          content.each{ |item| output.concat item; output.safe_concat NEWLINE }
        else
          output.concat content.to_s
        end
        output.safe_concat "</#{name}>"
      end

      def h_form_for(object, url, options={}, &block)
        capture_to_engine form_for(object, url, options={}, &block)
      end

      def h_fields_for(object, options={}, &block)
        capture_to_engine fields_for(object, options={}, &block)
      end

      def h_form(url, options={}, &block)
        capture_to_engine form_tag(url, options, &block)
      end

      def h_field_set(*args, &block)
        capture_to_engine field_set_tag(*args, &block)

      end

      private

      def capture_to_engine(content)
        return unless content.present?
        case current_engine
          when :erb
            @_out_buf << content
          else
            content
        end
      end
    end
  end
end