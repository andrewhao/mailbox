# Remote API user
module Api
  class User < BaseResource
    class << self
      def create(options={})
        RestClient.post(create_url,
                        options)
      end

      def find(id)
        RestClient.get singular_url(id)
      end

      def create_url
        "#{client.base_url}/author/create"
      end

      def singular_url(id)
        "#{client.base_url}/author/#{id}"
      end
    end
  end
end
