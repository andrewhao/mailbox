class ContactImportController < ApplicationController

  def approve
    puts "approve";
    if params[:email]
        @supporter = Supporter.find_by email: params[:email]
        if @supporter
          puts "Contact already exists"
        else
          @supporter = Supporter.new
        end
        
        @supporter.name = params[:name]
        @supporter.email = params[:email]
        @supporter.phone = params[:phone_number]
        
        if @supporter.save
          puts "Contact saved"
        else
          puts "Contact not saved"
        end
        render :js => "$(\"tr[name='#{params[:email]}']\").slideUp(700)"
      end
  end
  
  def reject
    puts "reject";
    # ; 
    render :js => "$(\"tr[name='#{params[:email]}']\").slideUp(700)"
  end

  # GET /contact_import
  # GET /contact_import.json
  def import
    @contacts = request.env['omnicontacts.contacts']
  end

end
