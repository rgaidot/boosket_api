module BoosketAPI
  module Services
    class Products < BoosketAPI::Base
      attr_accessor :startindex
      attr_accessor :itemsperpage
      attr_accessor :totalresults
      attr_accessor :products
      attr_accessor :xml
      
      def initialize(resp = nil)
        self.startindex, self.itemsperpage, self.totalresults = 0
        self.products = []
        self.xml = nil
        parse(resp) if resp
      end

      def find(conditions = {})
        uri = "#{BoosketAPI::Services.session.site}/#{BoosketAPI::Services.session.key}/shop/products"
        query = "?"
        query << "page=#{CGI.escape(conditions[:page])}" if conditions[:page] != nil
        query << "&tag=#{CGI.escape(conditions[:tag])}" if conditions[:tag] != nil
        query << "&sort_by=#{CGI.escape(conditions[:sort_by])}" if conditions[:sort_by] != nil
        query << "&ids=#{conditions[:ids] * ","}" if conditions[:ids] != nil
        query << "&references=#{conditions[:references] * ","}" if conditions[:references] != nil
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
        self.startindex =  self.xml.at('/products/startIndex').text
        self.itemsperpage =  self.xml.at('/products/itemsPerPage').text
        self.totalresults =  self.xml.at('/products/totalResults').text
        self.xml.xpath('/products/product').each do |p|
          self.products << Model::Product::new(p)
        end
      end
      
      def to_s(localtime = true)
        s  = ''
        s += "Start index: #{self.startindex}\n"
        s += "items per page: #{self.itemsperpage}\n"
        s += "Total results: #{self.totalresults}\n"
        s += "Products:\n"
        self.products.each { |i| s += i.to_s(localtime) }
        s += "\n"
      end
    end
  end
end