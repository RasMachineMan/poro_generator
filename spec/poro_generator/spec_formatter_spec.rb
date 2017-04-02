require "spec_helper"

describe ::PoroGenerator::SpecFormatter do

  let(:path)              { "app/service_objects/service_objects/users/profile/create.rb" }
  let(:service)           { described_class.new(path) }
  let(:hash_with_content) { service.call }

  let(:expected_spec_content) do

"""require 'spec_helper'

describe ::ServiceObjects::Users::Profile::Create do

  let(:service) { described_class.new() }

end"""

  end

  let(:expected_spec_path) { "spec/service_objects/users/profile/create_spec.rb" }

  it "returns path to a spec file" do
    expect(hash_with_content[:spec_content]).to eq expected_spec_content
  end

  it "returns spec file content" do
    expect(hash_with_content[:spec_destination_path]).to eq expected_spec_path
  end

end
