class LettersController < ApplicationController
  before_action :set_letter, only: [:show, :edit, :update, :destroy]
  before_action :set_letter2, only: [:send_letter, :unsend_letter]

  # GET /letters
  # GET /letters.json
  def index
    @letters = Api::Letter.all(current_user.email)
    if @letters.empty?
      redirect_to({ action: 'new'}, notice: 'Welcome to MailSafe! Get started writing your first letter below and click "Save" to see a preview of your message. To manage subscribers, click the Contacts tab above.')
    end
  end

  # GET /letters/1
  # GET /letters/1.json
  def show
  end

  # GET /letters/new
  def new
    @letter = Api::Letter.new
  end

  # GET /letters/1/edit
  def edit
  end

  # POST /letters
  # POST /letters.json
  def create
    @letter = Api::Letter.new(letter_params)
    @letter.draft = true

    respond_to do |format|
      if @letter.save(current_user)
        format.html { redirect_to letters_path, notice: 'Letter was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /letters/1
  # PATCH/PUT /letters/1.json
  def update
    respond_to do |format|
      if @letter.update(current_user, letter_params)
        format.html { redirect_to letters_path, notice: "Letter '#{@letter.subject}' was successfully updated." }
        format.json { head :no_content }
      else
        flash.now[:alert] = "Could not update letter. Please try again later."
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
    respond_to do |format|
      if @letter.send_mail!
        format.html { redirect_to letter_path(@letter), notice: 'Letter was successfully sent.' }
      else
        format.html { redirect_to letters_path, alert: "Error sending message. Please wait and try again." }
      end
    end
  end

  # GET /letters/1/unsend
  def unsend_letter
    respond_to do |format|
      if @letter.save
        format.html { redirect_to letters_path, notice: 'Letter was successfully unsent.' }
      else
        format.html { redirect_to letters_path }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_letter
      @letter = Api::Letter.find(params[:id])
    end

    def set_letter2
      @letter = Api::Letter.find(params[:letter_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def letter_params
      params.require(:api_letter).permit(:subject, :text)
    end
  end
