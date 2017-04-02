require_relative 'tooling'

module PoroGenerator
  class SpecFormatter

    include ::PoroGenerator::Tooling

    def initialize(path)
      @path = path
    end

    def call
      create_test_file_content
    end

    private

    attr_reader :path

    def create_test_file_content
      {
        spec_content: spec_content,
        spec_destination_path: spec_destination_path
      }
    end

    def spec_content
"""require 'spec_helper'

describe #{build_spec_namespace} do

  let(:service) { described_class.new() }

end"""
    end

    def build_spec_namespace
      namespaces.inject("") { |str, nspc| str << "::" << camelize(nspc) }.tap do |name_init|
        name_init << "::" << camelize(action_name)
      end
    end

    def namespaces
      path.split("/")[2..-2]
    end

    def spec_destination_path
      File.join("spec", namespaces, spec_file_name )
    end

    def action_name
      @action_name ||= path.split("/").last.split(".")[0]
    end

    def spec_file_name
      action_name << "_spec.rb"
    end

  end
end
