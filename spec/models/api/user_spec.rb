require "spec_helper"

describe Api::User do
  subject { described_class.new }

  let(:author_name) { "John Doe" }
  let(:author_email) { "hello@hello.com" }

  let(:headers) {
    {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}
  }

  describe "#find" do
    let(:url) do
      "https://mail-safe.appspot.com/author/#{author_email}"
    end

  describe "#create" do
    it "POSTs to https://mail-safe.appspot.com/author/create" do
      url = "https://mail-safe.appspot.com/author/create"

      stub_request(
        :post,
        url
      ).with(
        :body => {author_email: author_email, author_name: author_name},
        :headers => headers
      ).to_return(:body => JSON.generate({
        :author_name => author_name,
        :author_email => author_email
      }))

      created_instance = described_class.create(author_email: author_email, author_name: author_name)
      expect(created_instance).to be_instance_of described_class
    end
  end

    it "GETs at https://mail-safe.appspot.com/author/:email" do
      stub_request(
        :get,
        url
      ).with(
        :headers => headers
      ).to_return(:body => JSON.generate({
        :author_name => author_name,
        :author_email => author_email
      }))

      described_class.find(author_email)
    end

    it "returns nil for resource not found" do
      stub_request(:any, url).to_raise(
        RestClient::ResourceNotFound
      )

      result = described_class.find(author_email)
      expect(result).to be_nil
    end
  end
end
