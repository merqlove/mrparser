Sequel.default_timezone = :local

Sequel.extension :core_extensions
Sequel.extension :pg_array
Sequel.extension :pg_array_ops
Sequel.extension :postgres_schemata

Sequel::Model.raise_on_save_failure = false

Sequel::Model.plugin :raise_not_found
Sequel::Model.plugin :timestamps, update_on_create: true
Sequel::Model.plugin :validation_helpers
Sequel::Model.plugin :serialization
Sequel::Model.plugin :schema
Sequel::Model.plugin Sequel::Plugins::URLValidationHelpers
Sequel::Model.plugin Sequel::Plugins::SaveHelpers

Sequel::Plugins::Serialization.register_format(:json,
                                               lambda{|v| v.to_json },
                                               lambda{|v| JSON.parse(v, :symbolize_names => true) }
)

module MrParser

  # Loading MVC Structure

  module Extensions
    extend ActiveSupport::Autoload
    eager_autoload do
      autoload :Assets, 'app/extensions/assets'
    end
  end
  module Mailers
    extend ActiveSupport::Autoload
    eager_autoload do
      autoload :BaseMailer, 'app/mailers/base_mailer'
      autoload :UserMailer, 'app/mailers/user_mailer'
    end
  end
  module Models
    extend ActiveSupport::Autoload
    eager_autoload do
      autoload :Navigation, 'app/models/navigation'
      autoload :NavigationPage, 'app/models/navigation_page'
      autoload :Page, 'app/models/page'
      autoload :PageBlock, 'app/models/page_block'
    end
  end
  module Helpers
    extend ActiveSupport::Autoload
    eager_autoload do
      autoload :Asset, 'app/helpers/asset'
      autoload :Security, 'app/helpers/security'
      autoload :Output, 'app/helpers/output'
    end
  end
  module Controllers
    extend ActiveSupport::Autoload
    eager_autoload do
      autoload :Base, 'app/controllers/base'
      autoload :Static, 'app/controllers/static'
      autoload :Pages, 'app/controllers/pages'
      autoload :Index, 'app/controllers/index'
      autoload :Assets, 'app/controllers/assets'
    end
    module Admin
      extend ActiveSupport::Autoload
      eager_autoload do
        autoload :Base, 'app/controllers/admin/base'
        autoload :Pages, 'app/controllers/admin/pages'
        # autoload :Index, 'app/controllers/admin/index'
      end
    end
  end

  # Autoload loop

  # %w(extensions models helpers controllers).each do |folder|
  #   module_name = folder.titlecase
  #   unless MrParser.const_defined?(module_name)
  #     module_object = Module.new
  #     mod = MrParser.const_set(module_name.to_sym, module_object)
  #     Dir["app/#{folder}/*.rb"].sort.each do |file|
  #       file_name = File.basename(file, '.rb').titlecase.to_sym
  #       mod.autoload file_name, file
  #     end
  #     include mod
  #   end
  # end

end