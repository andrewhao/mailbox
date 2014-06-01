class LettersController < ApplicationController
  before_action :set_letter, only: [:show, :edit, :update, :destroy]
  before_action :set_letter2, only: [:send_letter, :unsend_letter]

  # GET /letters
  # GET /letters.json
  def index
    @letters = Letter.all
    if @letters.length==0
      redirect_to({ action: 'new'}, notice: 'Welcome to MailSafe! Get started writing your first letter below and click "Save" to see a preview of your message. To manage subscribers, click the Contacts tab above.')
    end
  end

  # GET /letters/1
  # GET /letters/1.json
  def show
  end

  # GET /letters/new
  def new
    @letter = Letter.new
  end

  # GET /letters/1/edit
  def edit
  end

  # POST /letters
  # POST /letters.json
  def create
    @letter = Letter.new(letter_params)
    
    @letter.draft=true

    respond_to do |format|
      if @letter.save
        format.html { redirect_to @letter, notice: 'Letter was successfully created.' }
        format.json { render action: 'show', status: :created, location: @letter }
      else
        format.html { render action: 'new' }
        format.json { render json: @letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /letters/1
  # PATCH/PUT /letters/1.json
  def update
    respond_to do |format|
      if @letter.update(letter_params)
        format.html { redirect_to @letter, notice: 'Letter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /letters/1
  # DELETE /letters/1.json
  def destroy
    @letter.destroy
    respond_to do |format|
      format.html { redirect_to letters_url }
      format.json { head :no_content }
    end
  end

  # GET /letters/1/send
  def send_letter
    puts "sending #{@letter.subject}"
    @letter.draft=false
    
    respond_to do |format|
      if @letter.save
        format.html { redirect_to @letter, notice: 'Letter was successfully sent.' }
        format.json { head :no_content }
      else
        format.html { render action: 'index' }
        format.json { render json: @letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /letters/1/unsend
  def unsend_letter
    puts "sending #{@letter.subject}"
    @letter.draft=true

    respond_to do |format|
      if @letter.save
        format.html { redirect_to letters_path, notice: 'Letter was successfully unsent.' }
        format.json { head :no_content }
      else
        format.html { render action: 'index' }
        format.json { render json: @letter.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_letter
      @letter = Letter.find(params[:id])
    end
    def set_letter2
      @letter = Letter.find(params[:letter_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def letter_params
      params.require(:letter).permit(:subject, :text)
    end
end
