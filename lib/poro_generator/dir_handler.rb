module PoroGenerator
  class DirHandler

    def initialize(namespaces)
      @namespaces = namespaces
      @namespace_errors = []
    end

    def call
      validate_top_namespace
      return_path_or_error
    end

    private

    attr_reader :namespaces, :namespace_errors

    def return_path_or_error
      namespace_errors.empty? ? directory_destination_path : namespace_errors
    end

    def directory_destination_path
      namespaces[0] = path_namespace_mapping[ top_namespace ]
      File.join(namespaces[0], namespaces)
    end

    def validate_top_namespace
      unless path_namespace_mapping.keys.include? top_namespace
        namespace_errors << "Top namespace must indicate a type of a service"
      end
    end

    def top_namespace
      namespaces[0].to_sym
    end

    def path_namespace_mapping
      {
        so: 'service_objects',
        fo: 'form_objects',
        qo: 'query_objects'
      }
    end
  end
end
