module MrParser
  module Controllers
    class Static < Sinatra::Base
      configure do
        set :views, App.views
        set :root, App.root

        disable :use_code, :method_override, :protection, :sessions
        enable :static
      end

      register Extensions::Assets

      def static!
        return if (public_dir = settings.public_folder).nil?
        public_dir = File.expand_path(public_dir)

        path = File.expand_path(public_dir + unescape(request.path_info))
        return unless path.start_with?(public_dir) and File.file?(path)

        env['sinatra.static_file'] = path

        unless settings.development? || settings.test?
          expires 1.year.to_i, :public, :max_age => 31536000
          headers 'Date' => Time.current.httpdate
        end

        send_file path, :disposition => nil
      end
    end
  end
end