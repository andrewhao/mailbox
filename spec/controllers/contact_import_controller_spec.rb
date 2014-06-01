require "spec_helper"

describe ContactImportController do
  let(:email) { "hello@gmail.com" }
  let(:name) { "Barbara" }
  let(:phone) { "1231231234" }

  xit "creates and persists and Api::Supporter" do
    params = {
      email: email,
      name: name,
      phone_number: phone
    }

    stub_request(:get, "https://mail-safe.appspot.com/supporter/#{email}").
      with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{}", :headers => {})

    stub_request(:post, "https://mail-safe.appspot.com/supporter/create").
      with(:body => {"email"=>"hello@gmail.com", "name"=>"Barbara", "phone"=>"1231231234"},
           :headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'53', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{}", :headers => {})

    get :approve, params
  end
end
