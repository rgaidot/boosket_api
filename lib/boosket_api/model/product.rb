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
      attr_accessor :image
      attr_accessor :thumbnail
      attr_accessor :original
      attr_accessor :combinations
      attr_accessor :tags

      def initialize(product = nil)
        self.id, self.link, self.title, self.description, self.reference = nil 
        self.price, self.discount_price, self.currency, self.quantity = 0
        self.image, self.thumbnail, self.original = nil
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
        self.image = product.at('image').text
        self.thumbnail = product.at('image')['thumbnail']
        self.original = product.at('image')['original']
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
        s += "Image: #{self.image}\n"
        s += "Thumbnail: #{self.thumbnail}\n"
        s += "Original: #{self.original}\n"
        s += "Price: #{self.price} #{self.currency}\n"
        s += "Discount price: #{self.discount_price} #{self.currency} (#{self.discount}%)\n"
        s += "Quantity: #{self.quantity}\n"
        s += "Combinations:\n"
        self.combinations.each { |i| s += i.to_s(localtime) }
        s += "Tags:\n"
        self.tags.each { |i| s += i.to_s(localtime) }
        s += "\n"
      end
    end
  end
end