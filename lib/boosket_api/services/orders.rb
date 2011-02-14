module BoosketAPI
  module Services
    class Orders < BoosketAPI::Base
      self.prefix = "/api/"
    end
    class Order < BoosketAPI::Base
      self.prefix = "/api/"
      def find(id)
        Order.find(id)
      end
      def set_address(address = {}, order = {})
        self.put(:set_address, :address => address, :order => order) 
      end
      def checkout(urls = {}, text = "")
        self.put(:checkout, :urls => urls, :text => text)
      end
      def paid
        self.put(:paid)
      end
    end
  end
end