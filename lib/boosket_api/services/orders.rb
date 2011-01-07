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
      def set_address(values = {})
        self.put(:set_address, :address => values) 
      end
      def checkout(urls = {})
        self.put(:checkout, :urls => urls) 
      end
      def paid
        self.put(:paid) 
      end
    end
  end
end