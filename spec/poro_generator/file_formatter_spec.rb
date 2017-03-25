require "spec_helper"

describe ::PoroGenerator::FileFormatter do

  let(:action_name) { "create" }
  let(:namespaces)  { ["so", "users", "profile"] }
  let(:service)     { described_class.new(namespaces: namespaces, action_name: action_name) }

  let(:expected_result) do

"""module ServiceObjects
  module Users
    module Profile
      class Create

        def initialize
        end

        def call
        end

        private


      end
    end
  end
end

# ::ServiceObjects::Users::Profile::Create.new()"""
  end

  it "formats the file" do
    expect(service.call).to eq expected_result
  end
end
