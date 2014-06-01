class Public::LetterController < ApplicationController
  def index
    token = params[:token]
    @supporter =  Api::Letter.get_interstitial(token)
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

    if @code == "1234" #temporary for testing
      @letter = Letter.first
    else
      respond_to do |format|
        format.html { redirect_to view_letter_start_path, notice: 'Invalid code or link.' }
      end
    end
  end 
end