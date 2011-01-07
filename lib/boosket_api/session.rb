module BoosketAPI
  class Session
    attr_accessor :server
    attr_accessor :key
    attr_accessor :url

    def initialize(attributes = {})
      self.server = attributes[:server] if attributes[:server] != nil
      self.key = attributes[:key] if attributes[:key] != nil
      BoosketAPI::Services.session = self
    end

    def site
      "http://#{self.key}@#{self.server}/api"
    end

    def valid?
      true
    end
  end
end