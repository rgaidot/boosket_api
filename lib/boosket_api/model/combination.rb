module BoosketAPI
  module Model
    class Combination
      attr_accessor :id
      attr_accessor :reference
      attr_accessor :price
      attr_accessor :discount_price
      attr_accessor :discount
      attr_accessor :currency
      attr_accessor :quantity
      attr_accessor :attributes

      def initialize(combination = nil)
        self.reference, self.price, self.discount_price, self.discount, self.currency = nil
        self.quantity = 0
        self.attributes = []
        parse(combination) if combination
      end
      
      def parse(combination)
        self.id = combination['id']
        self.reference = combination['reference']
        self.price = combination['price']
        self.discount_price = combination['discount_price']
        self.discount = combination['discount']
        self.currency = combination['currency']
        self.quantity = combination['quantity']
        combination.xpath('attribute').each do |a|
          self.attributes << Model::Attribute::new(a)
        end
      end
      
      def to_s(localtime = true)
        s  = "\n"
        s += "Id: #{self.id}\n"
        s += "Reference: #{self.reference}\n"
        s += "Price: #{self.price} #{self.currency}\n"
        s += "Discount price: #{self.discount_price} (#{self.discount}%) #{self.currency}\n"
        s += "Quantity: #{self.quantity}\n"
        s += "Attributes:\n"
        self.attributes.each { |i| s += i.to_s(localtime) }
        s += "\n"
      end
    end
  end
end