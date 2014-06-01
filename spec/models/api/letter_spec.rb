require "spec_helper"

describe Api::Letter do
  let(:author_email) { "author@me.com" }
  let(:text) do
    "<p>Four score and seven years ago...</p>"
  end
  let(:id) { "abcdefg" }

  subject { described_class.new }

  describe ".find" do
    let(:url) { "https://mail-safe.appspot.com/doc/#{id}" }

    it "finds the Api::Letter behind the API" do
      stub_request(
        :get,
        url
      ).with({
      }).to_return({
        body: JSON.generate({
          text: text
        })
      })

      response_instance = described_class.find(id)
      expect(response_instance).to be_instance_of described_class
    end
  end

  describe ".create" do
    let(:url) { "https://mail-safe.appspot.com/doc" }

    it "creates a new Api::Letter" do
      stub_request(
        :post,
        url
      ).with({
        text: text,
        author_email: author_email
      }).to_return({
        body: JSON.generate({
          text: text,
          author_email: author_email
        })
      })
    end
  end
end
