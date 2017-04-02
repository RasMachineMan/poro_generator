module PoroGenerator
  class ServicesGenerator < Rails::Generators::Base

    argument :action_name, required: true, type: :string
    argument :namespaces,  required: true, type: :array
    class_option :skip_test, desc: "Disable test file generation", default: false, aliases: "--st"

    def call
      if dir_handler.is_a? Array
        error_msg_missing_namespace
      else
        create_initializer_file
      end
    end

    private

    def create_initializer_file
      if File.exist?(destination)
        error_msg_file_exists
      else
        create_object_file
        create_spec_file unless options[:skip_test]
      end
    end

    def create_object_file
      create_file destination do
        file_formatter
      end
    end

    def create_spec_file
      create_file spec_formatter[:spec_destination_path] do
        spec_formatter[:spec_content]
      end
    end

    def dir_handler
      @dir_handler ||= ::PoroGenerator::DirHandler.new(namespaces).call
    end

    def spec_formatter
      @spec_formatter ||= ::PoroGenerator::SpecFormatter.new(destination).call
    end

    def destination
      @destination ||= dir_handler << "/#{action_name}.rb"
    end

    def file_formatter
      ::PoroGenerator::FileFormatter.new(
        namespaces:  namespaces,
        action_name: action_name
      ).call
    end

    def error_msg_file_exists
      puts "Upsssss! File already exists. Naming is tough though :)"
    end

    def error_msg_missing_namespace
      puts dir_handler[0]
    end

  end
end
