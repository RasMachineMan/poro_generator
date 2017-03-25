require "spec_helper"

describe ::PoroGenerator::ClassFormatter do

  let(:action_name){ "create" }
  let(:padding)    { ::PoroGenerator::Padding.new(2) }
  let(:service)    { described_class.new(padding, action_name) }

  let(:expected_result) do

p %{class Create

      def initialize
      end

      def call
      end

      private


    end}

  end

  it "formats the file" do
    expect(service.call).to eq expected_result
  end
end
