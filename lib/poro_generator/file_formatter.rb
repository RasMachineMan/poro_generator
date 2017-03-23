module PoroGenerator
  class FileFormatter

    def initialize(namespaces:, action_name:)
      @namespaces     = namespaces
      @action_name    = action_name
      @padding        = Padding.new(namespaces.size)
      @file_structure = String.new
    end

    def build
      open_module
      insert_class
      close_module
      file_structure
    end

    private

    attr_reader :namespaces, :action_name, :padding, :file_structure

    def open_module
      namespaces.each_with_index do |namespace, idx|
        file_structure << padding.increase_by(idx) << module_name(namespace)
      end
    end

    def close_module
      namespaces.size.times do |n|
        file_structure <<  "\n#{ padding.decrease_by(n) }" << "end"
      end
    end

    def insert_class
      file_structure << padding.max_length << class_name
    end

    def class_name
      "class #{action_name.capitalize}\n#{padding.max_length}end"
    end

    def module_name(namespace)
      if namespaces_mapping.keys.include? namespace.to_sym
        "module #{namespaces_mapping[namespace.to_sym]}\n"
      else
        "module #{namespace.capitalize}\n"
      end
    end

    def namespaces_mapping
      {
        so: 'ServiceObjects',
        fo: 'FormObjects',
        qo: 'QueryObjects'
      }
    end
  end
end
