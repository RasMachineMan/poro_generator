module PoroGenerator
  class ClassFormatter

    def initialize(padding, action_name)
      @padding     = padding
      @action_name = action_name
    end

    def format_class_content
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
      "class #{action_name.camelize}\n\n#{ yield }\n\n#{padding.max_length}end"
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
  end
end