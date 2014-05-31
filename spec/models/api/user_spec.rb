require "spec_helper"

describe Api::User do
  subject { described_class.new }

  let(:headers) {
    {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}
  }

  describe "#create" do
    it "POSTs to https://mail-safe.appspot.com/author/create" do
      author_email = "hello@hello.com"
      name = "Alfred Long"
      url = "https://mail-safe.appspot.com/author/create"

      described_class.create(author_email: author_email, name: name)

      expect(WebMock).to have_requested(
        :post,
        url
      ).with(
        :body => {author_email: author_email, name: name},
        :headers => headers
      )
    end
  end

  describe "#find" do
    it "GETs at https://mail-safe.appspot.com/author/:email" do
      author_email = "hello@hello.com"
      url = "https://mail-safe.appspot.com/author/#{author_email}"

      described_class.find(author_email)

      expect(WebMock).to have_requested(
        :get,
        url
      ).with(
        :headers => headers
      )

    end
  end
end
