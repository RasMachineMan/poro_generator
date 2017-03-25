module PoroGenerator
  class ServicesGenerator < Rails::Generators::Base

    argument :action_name, required: true, type: :string
    argument :namespaces,  required: true, type: :array
    # argument :options

    def create_initializer_file
      create_file destination do
        file_formatter.call
      end
    end

    private

    def dir_handler
      ### Handle the case when there is a namespace error
      ::PoroGenerator::DirHandler.new(namespaces).call
    end

    def file_formatter
      ::PoroGenerator::FileFormatter.new(
        namespaces: namespaces,
        action_name: action_name
      )
    end

    def destination
      dir_handler << "/#{action_name}.rb"
    end
  end
end
