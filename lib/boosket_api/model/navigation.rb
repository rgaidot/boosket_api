module BoosketAPI
  module Model
    class Navigation
      attr_accessor :scope
      attr_accessor :axes

      def initialize(navigation = nil)
        self.scope = nil
        self.axes = []
        parse(navigation) if navigation
      end
      
      def parse(navigation)
        self.scope = navigation['scope']
        navigation.xpath('axe').each do |a|
          self.axes << Model::Axe::new(a)
        end
      end
      
      def to_s(localtime = true)
        s  = ''
        s += "Scope: #{self.scope}\n"
        s += "Axes:\n"
        self.axes.each { |i| s += i.to_s(localtime) }
        s += "\n"
      end
    end
  end
end