module Api
  class Letter < BaseResource
    class << self
      def find(id)
        response = RestClient.get singular_resource_url(id)
        new JSON.parse(response)
      end

      def singular_resource_url(id)
        "#{client.base_url}/doc/#{id}"
      end

      def all(parent_id)
        response=RestClient.get collection_url(parent_id)
        json_array = JSON.parse(response)
        json_array.map do | hash |
          new hash
        end
      end

      def collection_url(parent_id)
        "#{client.base_url}/author/#{parent_id}/documents"
      end

      def authorize_link_and_get_username(token)
        response = RestClient.get supporter_link(token)
        JSON.parse(response)[:support_name]
      end

      def supporter_link(token)
        "#{client.base_url}/letter/#{token}"
      end

      def send_code(token, phone_method)
        RestClient.post(authorize_link(token), {method: phone_method})
      end

      def authorize_link(token)
        "#{client.base_url}/#{token}/auth"
      end

      def create(options={})
        RestClient.post(create_url, options)
      end

      def create_url
        "#{client.base_url}/doc/create"
      end
    end

    def save(user)
      begin
        self.class.create(to_hash.merge({author_email: user.email}))
        true
      rescue
        false
      end
    end

  end
end
