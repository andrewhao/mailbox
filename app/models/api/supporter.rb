module Api
  class Supporter < BaseResource
    class << self      
      def create(options={})
        response = RestClient.post(create_url,
                            options)

        new JSON.parse(response)
      end

      def find(id)
        response = RestClient.get singular_url(id)
        new JSON.parse(response)
      rescue RestClient::ResourceNotFound
        nil
      end

      def create_url
        "#{client.base_url}/supporter/create"
      end

      def singular_url(id)
        "#{client.base_url}/supporter/#{id}"
      end

      def collection_url(parent_id)
        "#{client.base_url}/author/#{parent_id}/supporters"
      end

      def all(parent_id)
        response=RestClient.get collection_url(parent_id)
        json_array = JSON.parse(response)
        json_array.map do | hash |
          new hash
        end
      end
    end

    def save
      self.class.create(to_hash)
      true
    end
    
    def id
      self.email
    end
  end
end