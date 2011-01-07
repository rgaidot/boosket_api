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
    end
  end
end