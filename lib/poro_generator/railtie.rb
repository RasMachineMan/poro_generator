module PoroGenerator
  class Railtie < Rails::Railtie

    generators do
      require 'poro_generator/services_generator'
    end

  end
end
