module BoosketAPI
  module Model
    class Attribute
      attr_accessor :id
      attr_accessor :scope
      attr_accessor :value

      def initialize(attribute = nil)
        self.scope, self.value, self.id = nil
        parse(attribute) if attribute
      end
      
      def parse(attribute)
        self.id = attribute['id']
        self.scope = attribute['scope']
        self.value = attribute['value']
      end
      
      def to_s(localtime = true)
        s = "Id: #{self.id}\n"
        s += "Scope: #{self.scope}\n"
        s += "Value: #{self.value}\n"
      end
    end
  end
end