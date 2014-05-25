module Sinatra
  module Templates
    def render(engine, data, options = {}, locals = {}, &block)
      # merge app-level options
      engine_options  = settings.respond_to?(engine) ? settings.send(engine) : {}
      options.merge!(engine_options) { |key, v1, v2| v1 }
      # extract generic options
      locals          = options.delete(:locals) || locals         || {}
      views           = options.delete(:views)  || settings.views || "./views"
      layout          = options[:layout]
      layout          = false if layout.nil? && options.include?(:layout)
      eat_errors      = layout.nil?
      layout          = engine_options[:layout] if layout.nil? or (layout == true && engine_options[:layout] != false)
      layout          = @default_layout         if layout.nil? or layout == true
      layout_options  = options.delete(:layout_options) || {}
      content_type    = options.delete(:content_type)   || options.delete(:default_content_type)
      layout_engine   = options.delete(:layout_engine)  || engine
      scope           = options.delete(:scope)          || self
      options.delete(:layout)

      # set some defaults
      options[:outvar]           ||= '@_out_buf'
      options[:default_encoding] ||= settings.default_encoding

      # compile and render template
      begin
        layout_was      = @default_layout
        @default_layout = false
        template        = compile_template(engine, data, options, views)
        output          = template.render(scope, locals, &block)
      ensure
        @default_layout = layout_was
      end

      # render layout
      if layout
        options = options.merge(:views => views, :layout => false, :eat_errors => eat_errors, :scope => scope).
            merge!(layout_options)
        catch(:layout_missing) { return render(layout_engine, layout, options, locals) { output } }
      end

      output.extend(ContentTyped).content_type = content_type if content_type
      output
    end
  end
end