class SupportersController < ApplicationController
  before_action :set_supporter, only: [:show, :edit, :update, :destroy]

  # GET /supporters
  # GET /supporters.json
  def index
    @supporters = Api::Supporter.all(current_user.email)
  end

  # GET /supporters/1
  # GET /supporters/1.json
  def show
  end

  # GET /supporters/new
  def new
    @supporter = Api::Supporter.new
  end

  # GET /supporters/1/edit
  def edit
    puts "edit"
  end

  # POST /supporters
  # POST /supporters.json
  def create
    # For now, updates are handled by the "create". We just detect if the supporter
    # already exists.
    # I have no idea why the form posts to 'create' instead of 'update' -NK
    update = false
    if params[:api_supporter][:email]
      @supporter = Api::Supporter.find(params[:api_supporter][:email])
      if @supporter
        update =true
        @supporter.destroy
      end
    end
    
    author_hash={author_email: current_user.email}
    author_hash.merge!(supporter_params)
    @supporter = Api::Supporter.new(author_hash)

    respond_to do |format|
      if @supporter.save
        if update
          format.html { redirect_to supporters_url, notice: "Supporter #{@supporter.name} was successfully updated." }
          format.json { render action: 'show', status: :created, location: @supporter }
        else
          format.html { redirect_to supporters_url, notice: "Supporter #{@supporter.name} was successfully created." }
          format.json { render action: 'show', status: :created, location: @supporter }
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @supporter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supporters/1
  # PATCH/PUT /supporters/1.json
  def update
    puts "update"
    respond_to do |format|
      if @supporter.update(supporter_params)
        format.html { redirect_to @supporter, notice: "Supporter #{@supporter.name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @supporter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supporters/1
  # DELETE /supporters/1.json
  def destroy
    @supporter.destroy
    respond_to do |format|
      format.html { redirect_to supporters_url }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supporter
      @supporter = Api::Supporter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supporter_params
      params.require(:api_supporter).permit(:name, :email, :phone)
    end
end
