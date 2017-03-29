module PoroGenerator
  class Railtie < Rails::Railtie

    generators do
      require 'services_generator'
    end

  end
end
