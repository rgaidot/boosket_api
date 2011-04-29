module BoosketAPI
  module Services
    class Shop < BoosketAPI::Base
      attr_accessor :name
      attr_accessor :status
      attr_accessor :specialty
      attr_accessor :baseline
      attr_accessor :startindex
      attr_accessor :itemsperpage
      attr_accessor :totalresults
      attr_accessor :products
      attr_accessor :navigations      
      attr_accessor :xml

      def find(conditions = {})
        self.name, self.specialty, self.baseline, self.xml = nil, nil, nil, nil
        self.products, self.navigations = [], []
        self.startindex, self.itemsperpage, self.totalresults = 0, 0, 0
        self.status = "pending"
        uri = "#{BoosketAPI::Services.session.site}/#{BoosketAPI::Services.session.key}/shop"
        query = "?"
        query << "page=#{conditions[:page]}" if conditions[:page] != nil
        query << "&nhits=#{conditions[:nhits]}" if conditions[:nhits] != nil
        query << "&tag=#{CGI.escape(conditions[:tag])}" if conditions[:tag] != nil
        query << "&sort_by=#{CGI.escape(conditions[:sort_by])}" if conditions[:sort_by] != nil
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
        self.name = self.xml.at('/shop/name').text
        self.specialty = self.xml.at('/shop/specialty').text
        self.baseline = self.xml.at('/shop/baseline').text
        self.startindex =  self.xml.at('/shop/startIndex').text
        self.itemsperpage =  self.xml.at('/shop/itemsPerPage').text
        self.totalresults =  self.xml.at('/shop/totalResults').text
        self.status = self.xml.at('/shop/status').text
        self.xml.xpath('/shop/navigations/navigation').each do |n|
          self.navigations << Model::Navigation::new(n)
        end
        self.xml.xpath('/shop/products/product').each do |p|
          self.products << Model::Product::new(p)
        end
      end

      def get_navigation_by(scope)
        results = []
        self.navigations.each { |n| if n.scope == scope then results << n end }
        return results
      end
      
      def to_s(localtime = true)
        s  = ''
        s += "Name: #{self.name}\n"
        s += "Specialty: #{self.specialty}\n"
        s += "Baseline: #{@baseline}\n"
        s += "Start index: #{self.startindex}\n"
        s += "items per page: #{self.itemsperpage}\n"
        s += "Total results: #{self.totalresults}\n"
        s += "Navigations:\n"
        self.navigations.each { |i| s += i.to_s(localtime) }
        s += "\n"
        s += "Products:\n"
        self.products.each { |i| s += i.to_s(localtime) }
        s += "\n"
      end
    end
  end
end

