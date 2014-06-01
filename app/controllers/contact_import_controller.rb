class ContactImportController < ApplicationController
  before_action :set_letter, only: [:show, :edit, :update, :destroy]

  # GET /contact_import
  # GET /contact_import.json
  def import
    @contacts = request.env['omnicontacts.contacts']
    # @user = request.env['omnicontacts.user']
    # puts "List of contacts of #{user[:name]} obtained from #{params[:importer]}:"
    @contacts.each do |contact|
      puts "Contact found: name => #{contact[:name]}, email => #{contact[:email]}, phone => #{contact[:phone_number]}"
      
      if contact[:email]
        @supporter = Supporter.find_by email: contact[:email]
        if @supporter
          puts "Contact already exists"
        else
          @supporter = Supporter.new
        end
        
        @supporter.name = contact[:name]
        @supporter.email = contact[:email]
        @supporter.phone = contact[:phone_number]
        
        if @supporter.save
          puts "Contact saved"
        else
          puts "Contact not saved"
        end
      end
    end
  end

end
