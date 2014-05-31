module Sinatra
  module Mount

    # def mount(app, route="/#{app.name.downcase}")
    #   %w{get post put delete patch options}.each do |method|
    #     self.send method.to_sym, "#{route}*" do
    #       app.call(
    #           env.merge!(
    #               'SCRIPT_NAME' => route.split('/').last,
    #               'PATH_INFO'   =>  params.delete('splat').join('/')
    #           )
    #       )
    #     end
    #   end
    # end

    def mount(app, route="/#{app.name.downcase}")
      before "#{route}*" do
        halt app.call(
                 env.merge(
                     'SCRIPT_NAME' => route.split('/').last,
                     'PATH_INFO'   =>  params.delete('splat').join('/')
                 )
             )
      end
    end

  end
end