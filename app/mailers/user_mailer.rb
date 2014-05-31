module MrParser
  module Mailers
    class UserMailer < Sinatra::Mailer::Base
      default from: ENV["MAIL_FROM"], content_type: 'text/html'

      class << self
        def invite!(invite)
          mail(to: invite.email, subject: "An invitation to join MrParser from #{invite.name}." ) do
            body <<-EOF.dedent
              Hi there,

              #{invite.name} has invited you to join MrParser.

              To learn more, and claim your invitation, visit:

              \thttp://example.com/claim/#{invite.code}

              Thanks,
              Admin
            EOF
          end
        end
        def activate!(user)
          mail(to: user.email, subject: "Welcome to MrParser!" ) do
            body    <<-EOF.dedent
              Hi there,

              Good news! #{user.parent_name || 'Admin'} has activated your MrParser account.

              Thanks,
              Admin
            EOF
          end
        end
      end
    end
  end
end