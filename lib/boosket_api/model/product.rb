module BoosketAPI
  module Model
    class Product
      attr_accessor :id
      attr_accessor :link
      attr_accessor :title
      attr_accessor :description
      attr_accessor :reference
      attr_accessor :price
      attr_accessor :discount_price
      attr_accessor :discount
      attr_accessor :currency
      attr_accessor :quantity
      attr_accessor :square
      attr_accessor :thumbnail
      attr_accessor :normal
      attr_accessor :original
      attr_accessor :combinations
      attr_accessor :tags

      def initialize(product = nil)
        self.id, self.link, self.title, self.description, self.reference = nil 
        self.price, self.discount_price, self.currency, self.quantity = 0
        self.square, self.thumbnail, self.normal = self.original = nil
        self.combinations = []
        self.tags = []
        parse(product) if product
      end

      def parse(product)
        self.id = product.at('id').text
        self.link = product.at('link')['href']
        self.title = product.at('title').text
        self.description = product.at('description').text
        self.reference = product.at('reference').text
        self.price = product.at('price').text
        self.discount_price = product.at('price')['discount_price']
        self.discount = product.at('price')['discount']
        self.currency = product.at('price')['currency']
        self.quantity = product.at('quantity').text
        self.square = Image.new(product.at('images').at('square'))
        self.thumbnail = Image.new(product.at('images').at('thumbnail'))
        self.normal = Image.new(product.at('images').at('normal'))
        self.original = Image.new(product.at('images').at('original'))
        product.xpath('combinations/combination').each do |c|
          self.combinations << Model::Combination::new(c)
        end
        product.xpath('tags/tag').each do |t|
          self.tags << Model::Tag::new(t)
        end
      end

      def to_s(localtime = true)
        s  = ''
        s += "Id: #{self.id}\n"
        s += "Reference: #{self.reference}\n"
        s += "Link: #{self.link}\n"
        s += "Title: #{self.title}\n"
        s += "Description: #{self.description}\n"
        s += "Square: #{self.square}\n"
        s += "Thumbnail img: #{self.thumbnail}\n"
        s += "Normal img: #{self.normal}\n"
        s += "Original img: #{self.original}\n"
        s += "Price: #{self.price} #{self.currency}\n"
        s += "Discount price: #{self.discount_price} #{self.currency} (#{self.discount}%)\n"
        s += "Quantity: #{self.quantity}\n"
        s += "Combinations:\n"
        self.combinations.each { |i| s += i.to_s(localtime) }
        s += "Tags:\n"
        self.tags.each { |i| s += i.to_s(localtime) }
        s += "\n"
      end
      
      class Image
        attr_accessor :src
        attr_accessor :width
        attr_accessor :height
        
        def initialize(image = nil)
          self.src = nil
          self.width = self.height = 0
          parse(image) if image
        end
        
        def parse(image)
          self.src = image.text
          self.width = image['width']
          self.height = image['height']
        end
        
        def to_s(localtime = true)
          s  = ''
          s += "Image source: #{self.src}\n"
          s += "Image width: #{self.width}\n"
          s += "Image height: #{self.height}\n"
          s += "\n"
        end
        
      end
    end
  end
end