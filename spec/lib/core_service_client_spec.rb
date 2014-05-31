require 'spec_helper'

describe CoreServiceClient do
  subject { described_class.new }

  it "initializes" do
    expect(described_class.new).to be_instance_of CoreServiceClient
  end

  describe "#base_url" do
    it "returns production URL on dev" do
      allow(Rails).to receive(:env).and_return(:development)
      expect(subject.base_url).to eq "https://mail-safe.appspot.com"
    end

    it "returns production URL on production" do
      allow(Rails).to receive(:env).and_return(:staging)
      expect(subject.base_url).to eq "https://mail-safe.appspot.com"
    end
  end
end
