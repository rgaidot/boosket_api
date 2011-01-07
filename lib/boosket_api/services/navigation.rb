module BoosketAPI
  module Services
    class Navigation < BoosketAPI::Base
      attr_accessor :navigations
      attr_accessor :xml
      
      def initialize
        self.navigations = []
        self.xml = nil
      end
      
      def find()
        uri = "#{BoosketAPI::Services.session.site}/#{BoosketAPI::Services.session.key}/shop/navigations"
        begin
          response = Net::HTTP.get_response(URI.parse("#{uri}"))
          parse(response.body)
          self
        rescue Exception => ex
          pp(ex)
        end
      end

      def parse(response)
        self.xml = Nokogiri::XML(response)
        self.xml.xpath('/navigations/navigation').each do |n|
          self.navigations << Model::Navigation::new(n)
        end
      end
      
      def get_navigation_by(scope)
        results = []
        self.navigations.each { |n| if n.scope == scope then results << n end }
        return results
      end
    end
  end
end