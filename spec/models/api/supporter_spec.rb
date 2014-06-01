require "spec_helper" 

describe Api::Supporter do
  subject { described_class.new }

  let(:name) { "Kim Supporter" }
  let(:phone) { "5551231234" }
  let(:email) { "kimsupporter@mailinator.com" }
  let(:author_email) { "myemail@mailinator.com" }

  let(:headers) {
    {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}
  }

  describe ".find" do
    let(:url) do
      "https://mail-safe.appspot.com/supporter/#{email}"
  end

  describe ".create" do
    it "POSTs to https://mail-safe.appspot.com/supporter/create" do
      url = "https://mail-safe.appspot.com/supporter/create"

      stub_request(
        :post,
        url
      ).with(
        :body => {
          name: name,
          phone: phone,
          email: email,
          author_email: author_email
        },
        :headers => headers
      ).to_return(:body => JSON.generate({
        :name => name,
        :email => email
      }))

      created_instance = described_class.create({
        name: name,
        phone: phone,
        email: email,
        author_email: author_email
      })

      expect(created_instance).to be_instance_of described_class
    end
  end

  it "GETs at https://mail-safe.appspot.com/supporter/:email" do
      stub_request(
        :get,
        url
      ).with(
        :headers => headers
      ).to_return(:body => JSON.generate({
        :name => name,
        :email => email
      }))

      described_class.find(email)
    end

    it "returns nil for resource not found" do
      stub_request(:any, url).to_raise(
        RestClient::ResourceNotFound
      )

      result = described_class.find(email)
      expect(result).to be_nil
    end
  end

  describe "#save" do
    it "sends a post" do
      params = {foo: "bar"}
      instance = described_class.new params

      url = "https://mail-safe.appspot.com/supporter/create"

      stub_request(
        :post,
        url
      ).with(
        :body => params,
        :headers => headers
      ).to_return(:body => JSON.generate(params))

      expect(instance.save).to be_true
    end
  end

  describe "attribute setting" do
    it "will persist an attribute to create on save" do
      params = {foo: "bar"}
      expected_params = {foo: "bar", newfoo: "baz"}
      instance = described_class.new params
      instance.newfoo = "baz"

      url = "https://mail-safe.appspot.com/supporter/create"

      stub_request(
        :post,
        url
      ).with(
        :body => expected_params,
        :headers => headers
      ).to_return(:body => JSON.generate(expected_params))

      expect(instance.save).to be_true
    end
  end

  describe "#id" do
    subject { described_class.new(email: email) }

    it "aliases email" do
      expect(subject.id).to eq subject.email
    end
  end
end
