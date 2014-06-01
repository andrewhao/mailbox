class SessionsController < ApplicationController

  def new
    redirect_to '/auth/google_oauth2'
  end

  def create
    auth = request.env["omniauth.auth"]
    email = auth['info']['email']
    name = auth['info']['name']

    user = Api::User.find(email) || Api::User.create(author_email: email, author_name: name)

    reset_session
    session[:user_id] = user.email
    redirect_to letters_url
  end

  def destroy
    reset_session
    redirect_to root_url
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
