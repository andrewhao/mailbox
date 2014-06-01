require 'hashie/mash'

module Api
  class BaseResource < Hashie::Mash
    def self.client
      @client ||= CoreServiceClient.new
    end
  end
end
