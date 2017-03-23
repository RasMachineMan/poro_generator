module PoroGenerator
  class ServicesGenerator < Rails::Generators::Base

    argument :action_name, required: true, type: :string
    argument :namespaces,  required: true, type: :array
    # argument :options

    # build destination dynamically, based on the namespaces given
    # handle error if first namespace not found
    # handle error if folder, inside namespace, not found

    def create_initializer_file
      create_file destination do
        file_formatter.build
      end
    end

    private

    def dir_handler
      ::PoroGenerator::DirHandler.new(namespaces).path
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
