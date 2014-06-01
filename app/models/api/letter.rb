module Api
  class Letter < BaseResource
    def self.find(id)
      response = RestClient.get singular_resource_url(id) 
      new JSON.parse(response)
    end

    def self.singular_resource_url(id)
      "#{client.base_url}/doc/#{id}"
    end
  end
end
