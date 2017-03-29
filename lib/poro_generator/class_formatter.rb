require_relative 'tooling'

module PoroGenerator
  class ClassFormatter

    include ::PoroGenerator::Tooling

    def initialize(padding, action_name)
      @padding     = padding
      @action_name = action_name
    end

    def call
      class_name_with_content { insert_class_content }
    end

    private

    attr_reader :padding, :action_name

    def insert_class_content
      String.new.tap do |str|
        str << insert_initialize
        str << insert_call
        str << insert_private
      end
    end

    def class_name_with_content
      "class #{camelize(action_name)}\n\n#{ yield }\n\n#{padding.max_length}end"
    end

    def insert_initialize
       padding.method_padding << _initialize
    end

    def _initialize
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
  end
end
