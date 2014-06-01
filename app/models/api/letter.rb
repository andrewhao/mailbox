module Api
  class Letter < BaseResource
    def self.find(id)
      RestClient.get singular_resource_url(id) 
    end

    def self.singular_resource_url(id)
      "#{base_url}/doc/#{id}"
    end
  end
end
