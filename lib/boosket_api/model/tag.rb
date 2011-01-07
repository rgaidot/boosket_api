module BoosketAPI
  module Model
    class Tag
      attr_accessor :scope
      attr_accessor :value

      def initialize(tag = nil)
        self.scope, self.value = nil
        parse(tag) if tag
      end
      
      def parse(axe)
        self.scope = axe['scope']
        self.value = axe['value']
      end
      
      def to_s(localtime = true)
        s  = ''
        s += "Scope: #{self.scope}\n"
        s += "Value: #{self.value}\n"
        s += "\n"
      end
    end
  end
end