module PoroGenerator
  class Padding

    def initialize(namespaces_size)
      @namespaces_size = namespaces_size
    end

    def increase_by(increaser)
      base * increaser
    end

    def decrease_by(decreser)
      end_padding[(decreser * 2)..end_padding.length]
    end

    def max_length
      base * namespaces_size
    end

    def method_padding
      max_length + base
    end

    private

    attr_reader :namespaces_size

    def end_padding
      max_length[1..(max_length.size - 2)]
    end

    def base
      "  "
    end
  end
end
