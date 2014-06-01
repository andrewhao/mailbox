class ContactImportController < ApplicationController

  def approve

    if params[:email]
      @supporter = Api::Supporter.find params[:email]
      if @supporter
        puts "Contact already exists"
      else
        @supporter = Api::Supporter.new(author_email: current_user.email)
      end

      @supporter.name = params[:name]
      @supporter.email = params[:email]
      @supporter.phone = params[:phone_number]

      if @supporter.save
        puts "Contact saved"
      else
        puts "Contact not saved"
      end
      render :js => "$(\"tr[name='#{params[:email]}']\").hide();$('#alertText').text('#{params[:name]} has been imported into your supporter list.');$('#alert').show()"
    end
  end
  
  def reject
    render :js => "$(\"tr[name='#{params[:email]}']\").hide()"
  end

  # GET /contact_import
  # GET /contact_import.json
  def import
    @contacts = request.env['omnicontacts.contacts']
    @contacts = @contacts.reject do |contact|
      !contact[:phone_number] || !contact[:email]
    end
  end

end
