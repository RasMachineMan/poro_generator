module PoroGenerator
  class FileFormatter

    def initialize(namespaces:, action_name:)
      @namespaces     = namespaces
      @action_name    = action_name
      @padding        = ::PoroGenerator::Padding.new(namespaces.size)
      @file_structure = String.new
    end

    def build
      open_module
      insert_class
      close_module
      insert_namespaced_initializer
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
      file_structure << padding.max_length << class_name_with_content { insert_class_content }
    end

    def class_name_with_content
      "class #{action_name.camelize}\n\n#{ yield }\n\n#{padding.max_length}end"
    end

    def module_name(namespace)
      if namespaces_mapping.keys.include? namespace.to_sym
        "module #{namespaces_mapping[namespace.to_sym]}\n"
      else
        "module #{namespace.capitalize}\n"
      end
    end

    def insert_class_content
      String.new.tap do |str|
        str << insert_initialize
        str << insert_call
        str << insert_private
      end
    end

    def insert_initialize
       padding.method_padding << _intialize
    end

    def _intialize
      "def initialize\n#{padding.method_padding}end\n\n"
    end

    def insert_call
      padding.method_padding << _call
    end

    def _call
      "def call\n#{padding.method_padding}end\n\n"
    end

    def insert_private
       padding.method_padding << _private
    end

    def _private
      "private\n"
    end

    def insert_namespaced_initializer
      file_structure << "\n\n" << namespaced_initializer
    end

    def namespaced_initializer
      namespaces.inject("# ") { |str, n| str << "::" << n.camelize }.tap do |name_init|
        name_init << "::" << action_name.camelize << ".new()"
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
