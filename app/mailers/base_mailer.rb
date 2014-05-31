module MrParser
  module Mailers
    class BaseMailer < Sinatra::Mailer::Base
      default from: ENV["MAIL_FROM"], content_type: 'text/html'

      class << self
        def feedback!(text, email = nil, name='')
          mail(to: "am@mrcr.ru", subject: 'Feedback', body: text) do
            reply_to "#{name}<#{email}>" if email.present?
          end
        end
      end
    end
  end
end
