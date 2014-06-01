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
    end
  end
end