class Public::LetterController < ApplicationController
  def index
    token = params[:token]
    @supporter =  Api::Letter.authorize_link_and_get_username(token)
    flash.now[:alert] = "Invalid or expired link." unless @supporter
  end
  
  def send_code
    token = params[:token]
    phone_method = params[:phone_method]
    Api::Letter.send_code(token,phone_method)
    respond_to do |format|
      format.html { redirect_to enter_code_path, notice: 'A code has been sent to the phone number on file.' }
      format.json { render action: '', status: :sent }
    end
  end
  
  def enter_code
  end
    
  def view
    @code = params[:code]
    @token = params[:token]

    begin
      response = Api::Letter.find_by_token_and_code(code, token)
      @letter = response
    rescue
      respond_to do |format|
        format.html { redirect_to view_letter_start_path, notice: 'Invalid code or link.' }
      end
    end
  end 
end