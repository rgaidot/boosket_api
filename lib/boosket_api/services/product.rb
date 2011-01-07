module BoosketAPI
  module Services
    class Product < BoosketAPI::Base
      attr_accessor :product
      attr_accessor :xml
      
      def initialize
        self.product, self.xml = nil
      end
      
      def find(conditions = {})
        uri = "#{BoosketAPI::Services.session.site}/#{BoosketAPI::Services.session.key}/shop/product"
        query = "?"
        query << "id=#{CGI.escape(conditions[:id])}" if conditions[:id] != nil
        query << "reference=#{CGI.escape(conditions[:reference])}" if conditions[:reference] != nil
        begin
          response = Net::HTTP.get_response(URI.parse("#{uri}/#{query}"))
          parse(response.body)
          self
        rescue Exception => ex
          pp(ex)
        end
      end

      def parse(response)
        self.xml = Nokogiri::XML(response)
        self.product = Model::Product::new(self.xml.at('/products/product'))
      end
    end
  end
end