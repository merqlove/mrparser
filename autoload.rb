Sequel.default_timezone = :local

Sequel.extension :core_extensions
Sequel.extension :pg_array
Sequel.extension :pg_array_ops

Sequel::Model.raise_on_save_failure = false

Sequel::Model.plugin :raise_not_found
Sequel::Model.plugin :timestamps, update_on_create: true
Sequel::Model.plugin :validation_helpers
Sequel::Model.plugin :serialization
Sequel::Model.plugin Sequel::Plugins::URLValidationHelpers
Sequel::Model.plugin Sequel::Plugins::SaveHelpers

Sequel::Plugins::Serialization.register_format(:json,
                                               lambda{|v| v.to_json },
                                               lambda{|v| JSON.parse(v, :symbolize_names => true) }
)

# Sequel::Plugins::Serialization.register_format(:pg_uuid_array,
#                                                lambda{|v| Sequel::Postgres::PGArray.new(v, :uuid) },
#                                                lambda{|v| Sequel::Postgres::PGArray::Parser.new(v).parse }
# )

# Sequel::Postgres::PGArray.register('uuid', :type_symbol => :string)

module MrParser

  # Loading MVC Structure

  module Extensions
    extend ActiveSupport::Autoload
    eager_autoload do
      autoload :Assets, 'app/extensions/assets'
    end
  end
  module Models
    extend ActiveSupport::Autoload
    eager_autoload do
      autoload :Page, 'app/models/page'
      autoload :PageBlock, 'app/models/page_block'
    end
  end
  module Helpers
    extend ActiveSupport::Autoload
    eager_autoload do
      autoload :Assets, 'app/helpers/assets'
    end
  end
  module Routes
    extend ActiveSupport::Autoload
    eager_autoload do
      autoload :Base, 'app/routes/base'
      autoload :Static, 'app/routes/static'
      autoload :Pages, 'app/routes/pages'
      autoload :Index, 'app/routes/index'
      autoload :Assets, 'app/routes/assets'
    end
    module Admin
      extend ActiveSupport::Autoload
      eager_autoload do
        autoload :Base, 'app/routes/admin/base'
        autoload :Pages, 'app/routes/admin/pages'
        # autoload :Index, 'app/routes/admin/index'
      end
    end
  end

  # %w(extensions models helpers routes).each do |folder|
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