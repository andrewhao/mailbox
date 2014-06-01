module Api
  class Letter < BaseResource

    def update(author, params)
      params.reverse_merge!(author_email: author.email)
      begin
        RestClient.post self.class.singular_document_resource_url(id), params
      rescue => e
        puts e.message
        false
      end
    end

    def destroy
      RestClient.delete self.class.singular_document_resource_url(id)
    end

    def save(user)
      begin
        self.class.create(to_hash.merge({author_email: user.email}))
        true
      rescue
        false
      end
    end

    def send_mail!
      RestClient.post "#{self.class.singular_document_resource_url(id)}/send", {}
      true
    rescue RestClient::Exception
      false
    end

    def draft?
      status == "draft"
    end

    def id
      return to_hash['key']
    end

    class << self
      def create(options={})
        RestClient.post(create_url, options)
      end

      def find(id)
        response = RestClient.get singular_document_resource_url(id)
        new JSON.parse(response)
      end

      def all(parent_id)
        response=RestClient.get collection_url(parent_id)
        json_array = JSON.parse(response)
        json_array.map do | hash |
          new hash
        end
      end

      def find_by_token_and_code(token, code)
        response = RestClient.get "#{singular_resource_url(token)}/#{code}"
        new JSON.parse(response)
      end

      def singular_document_resource_url(id)
        "#{client.base_url}/doc/#{id}"
      end

      def singular_letter_resource_url(token)
        "#{client.base_url}/letter/#{token}"
      end

      def collection_url(parent_id)
        "#{client.base_url}/author/#{parent_id}/documents"
      end

      def authorize_link_and_get_username(token)
        begin
          response = RestClient.get singular_letter_resource_url(token)
          JSON.parse(response)[:support_name]
        rescue
          false
        end
      end

      def send_code(token, phone_method)
        RestClient.post(authorize_link(token), {method: phone_method})
      end

      def authorize_link(token)
        "#{client.base_url}/#{token}/auth"
      end

      def create_url
        "#{client.base_url}/doc/create"
      end
    end

    def crud_path
      h = Rails.application.routes.url_helpers
      id.nil? ? h.letters_path : h.letter_path(id)
    end

    def crud_form_action
      id.nil? ? :post : :patch
    end

    def to_param
      id
    end

    def persisted?
      false
    end
  end
end
