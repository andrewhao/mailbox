require 'hashie/mash'

module Api
  class BaseResource < Hashie::Mash
    include ActiveModel::Conversion
    include ActiveModel::Validations
    
    delegate :base_url, to: :client

    def self.client
      @client ||= CoreServiceClient.new
    end
  end
end
