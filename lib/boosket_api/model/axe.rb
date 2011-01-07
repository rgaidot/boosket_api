module BoosketAPI
  module Model
    class Axe
      attr_accessor :value
      attr_accessor :nhits

      def initialize(axe = nil)
        self.value, self.nhits = nil
        parse(axe) if axe
      end
      
      def parse(axe)
        self.value = axe['value']
        self.nhits = axe['nhits']
      end
      
      def to_s(localtime = true)
        s  = ''
        s += "Value: #{self.value}\n"
        s += "nhits: #{self.nhits}\n"
        s += "\n"
      end
    end
  end
end