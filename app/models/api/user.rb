# Remote API user
module Api
  class User < BaseResource
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
        "#{client.base_url}/author/create"
      end

      def singular_url(id)
        "#{client.base_url}/author/#{id}"
      end
    end
    
    def id
      self.email
    end
  end
end
