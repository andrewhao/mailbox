require 'hashie/mash'

module Api
  class BaseResource < Hashie::Mash
    delegate :base_url, to: :client

    def self.client
      @client ||= CoreServiceClient.new
    end
  end
end
