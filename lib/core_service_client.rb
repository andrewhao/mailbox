# Connects to our backend core service.
class CoreServiceClient
  attr_accessor :environment

  def initialize
    @environment = Rails.env
  end

  def base_url
    "https://mail-safe.appspot.com"
  end
end
