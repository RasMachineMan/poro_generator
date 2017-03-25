require "spec_helper"

describe ::PoroGenerator::Padding do

  let(:padding)        { described_class.new(namespaces.size) }
  let(:namespaces)     { ["top", "mdl", "btn"] }
  let(:base)           { "  " }
  let(:max_padding)    { base * namespaces.size }
  let(:single_padding) { base }
  let(:zero_padding)   { "" }

  it "increases padding by given number" do
    padding_size_4 = padding.increase_by(4)
    padding_size_3 = padding.increase_by(5)
    expect(padding_size_4).to eq base * 4
    expect(padding_size_3).to eq base * 5
  end

  it "decreases padding by given number" do
    padding_minus_1 = padding.decrease_by(1)
    padding_minus_2 = padding.decrease_by(2)
    expect(padding_minus_1).to eq single_padding
    expect(padding_minus_2).to eq zero_padding
  end

  it "returns max length padding" do
    padding_max = padding.max_length
    expect(padding_max).to eq max_padding
  end

  it "returns method padding" do
    method_padding = padding.method_padding
    expect(method_padding).to eq base + max_padding
  end

end
