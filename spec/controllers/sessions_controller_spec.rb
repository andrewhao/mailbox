require 'spec_helper'

describe SessionsController do
  let(:email) { "asdf@asdf.com" }
  let(:name) { "name" }

  before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = {
        'uid' => '12345',
        'provider' => 'google_oauth2',
        'info' => {
          'name' => name,
          'email' => email
        }
      }
  end

  describe "GET 'new'" do
    it "redirects users to authentication" do
      get 'new'
      assert_redirected_to '/auth/google_oauth2'
    end
  end

  describe "finds the existing user" do
    it "redirects user back to letter index view" do
      mock_user = double('user', :email => email)

      expect(Api::User).to receive(:find)
        .with(email)
        .and_return(mock_user)
        .any_number_of_times

      visit '/signin'

      page.should have_content('Signed in!')
      current_path.should == letters_path
    end
  end

  describe "creates a new user when no existing user" do
    it "redirects user back to letter index view" do
      mock_user = double('user', :email => email)

      expect(Api::User).to receive(:find)
        .with(email)
        .and_return(nil)
        .any_number_of_times

      expect(Api::User).to receive(:create)
        .with(author_email: email, author_name: name)
        .and_return(mock_user)

      visit '/signin'

      page.should have_content('Signed in!')
      current_path.should == letters_path
    end
  end
end
