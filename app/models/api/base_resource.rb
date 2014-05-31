module Api
  class BaseResource
    def self.client
      @client ||= CoreServiceClient.new
    end
  end
end
