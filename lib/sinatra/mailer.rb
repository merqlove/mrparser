require 'active_support/core_ext/class/attribute'

module Sinatra
  module Mailer
    class Base
      class_attribute :default_params
      self.default_params = {
          mime_version: "1.0",
          charset:      "UTF-8",
          content_type: "text/plain",
          content_transfer_encoding: "8bit",
          from: ENV['MAIL_FROM'] || 'localhost'
      }.freeze

      class << self
        def default(value = nil)
          self.default_params = default_params.merge(value).freeze if value
          default_params
        end
        alias :default_options= :default

        def mail(headers={}, &block)
          default_values = {}
          self.default.each do |k,v|
            default_values[k] = v.is_a?(Proc) ? instance_eval(&v) : v
          end
          headers = headers.reverse_merge(default_values)

          mail = Mail.new(headers, &block)
          mail.deliver
          mail
        end
      end
    end
  end
end
