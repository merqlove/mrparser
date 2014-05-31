module Sinatra
  module SequelConnect
    def db_connect(config)
      if defined?(JRUBY_VERSION)
        Sequel.connect(
            "#{config[:adapter]}://#{config[:host]}",
            port: config[:port],
            user: config[:user],
            password: config[:password],
            database: config[:database]
        )
      else
        Sequel.connect(config)
      end
    end
  end
end