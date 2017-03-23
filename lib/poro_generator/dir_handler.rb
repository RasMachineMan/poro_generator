module PoroGenerator
  class DirHandler

    def initialize(namespaces)
      @namespaces = namespaces
    end

    def path
      directory_destination_path
    end

    private

    attr_reader :namespaces

    def directory_destination_path
      File.join(Rails.root, namespaces)
    end

  end
end
