require "spec_helper"

describe ::PoroGenerator::DirHandler do

  let(:action)        { described_class.new(namespaces) }
  let(:expected_path) { "app/service_objects/service_objects/users/admin" }
  let(:error)         { "Upassss!, Make sure the top namespace indicates a type of a service" }

  context "with proper top namespace" do

    let(:namespaces) { ["so", "users", "admin"] }

    it "builds the path based on namespaces" do
      expect(action.call).to eq expected_path
    end
  end

  context "without proper top namespace" do

    let(:namespaces)  { ["create", "users", "admin"] }
    let(:dir_handler) { action.call }

    it "doesn't build the path based on namespaces" do
      expect(dir_handler).not_to eq expected_path
    end

    it "returns an array containg an error" do
      expect(dir_handler).to match_array([error])
    end

  end
end
