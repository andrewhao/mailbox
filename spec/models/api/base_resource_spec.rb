require "spec_helper"

describe Api::BaseResource do
  subject { described_class.new(json_hash) }

  let(:name) { "John Doe" }
  let(:fruit) { "bananas" }

  let(:json_hash) do
    { :name => name, :fruit => fruit }
  end

  describe "attributes as methods" do
    it "can call the value from the hash as a method" do
      expect(subject.name).to eq name
      expect(subject.fruit).to eq fruit
    end
  end

  describe ".client" do
    it "is instance of CoreServiceClient" do
      expect(described_class.client).to be_instance_of CoreServiceClient
    end
  end
end
