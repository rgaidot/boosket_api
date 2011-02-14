require 'test_helper'

module BoosketAPI
  module Test
    class BoosketAPITest < ::Test::Unit::TestCase
      BoosketAPI::Session.new({:server => "localhost:3000", :key => "35b6cfb2db59a976e0e3504fc6a9df"})

      def test_shop
        bsk = BoosketAPI::Services::Shop.new
        shop = bsk.find()
        pp(shop)
      end
      
      def test_shop_find_with_limit
        bsk = BoosketAPI::Services::Shop.new
        shop = bsk.find({:nhits => 1})
        pp(shop)
      end

      def test_products_with_params
        bsk = BoosketAPI::Services::Products.new
        products = bsk.find({:tag => "gps"})
        pp(products)
      end

      def test_products_with_sort
        bsk = BoosketAPI::Services::Products.new
        products = bsk.find({:sort_by => "discount desc"})
        pp(products)
      end

      def test_products_find_by_references
        bsk = BoosketAPI::Services::Products.new
        products = bsk.find({:references => ["RV510", "LG42LD550"]})
        pp(products)
      end
      
      def test_products_find_by_ids
        bsk = BoosketAPI::Services::Products.new
        products = bsk.find({:ids => ["canon-powershot-sx210-is-noir", "western-digital-my-passport-essential-500-go-rouge-usb-30-usb-20"]})
        pp(products)
      end

      def test_products_find_with_limit
        bsk = BoosketAPI::Services::Products.new
        products = bsk.find({:nhits => 1})
        pp(products)
      end

      def test_product
        bsk = BoosketAPI::Services::Product.new
        product = bsk.find({:id => "jean-coupe-droite-stretch-noir"}).product
        pp(product)
      end

      def test_navigation
        nav = BoosketAPI::Services::Navigation.new
        nav.find()
        pp(nav.navigations)
        pp(nav.get_navigation_by('categories'))
      end

      def test_purchase_order
        @boosket_session = BoosketAPI::Session.new({:server => "localhost:3000", 
          :key => "35b6cfb2db59a976e0e3504fc6a9df"})
        if @boosket_session.valid?
          p = BoosketAPI::Services::Order.new
          pp(p.find(1))
        end
        o = BoosketAPI::Services::Orders.new(
          :ordered_products => {
            "REF342B" => { :reference => "REFBLK28", :combination => 6, :quantity => 2 }
          },
          :shop_key => "35b6cfb2db59a976e0e3504fc6a9df",
          :facebook_uid => "541245684",
          :complement_order => "mykey:mavalue"
        )
        o.save
        if o.save
          p = BoosketAPI::Services::Order.find(o) # testing getter 
          pp(p) 
          p.set_address({ 
            :id => nil, :designation => "Mr ",
            :firstname => "Firstname", :name => "Lastname",
            :email => "Email",
            :address => "Address", :address_2  => "Address 2",
            :city => "City", :country => "Country", :zip_code => "ZipCode"}, 
            {:complement_order => "mykey:mavalue, clientid:1234567"})
          pp(p)
        end
      end

      def test_orders_by_shop_key
        p = BoosketAPI::Services::Orders.all(:params => {:key => "35b6cfb2db59a976e0e3504fc6a9df", 
          :dates => '2011-01-30,2011-01-31'})
        pp(p)
      end

      def test_checkout_order
        p = BoosketAPI::Services::Order.find(1)
        paypal = p.checkout({:success => "http://localhost:3000/success", 
          :cancel => "http://localhost:3000/canceled"}, "this is a text")
        puts paypal
      end

      def test_checkout_paid
        p = BoosketAPI::Services::Order.find(1).paid
        pp(p)
      end
      
      def test_purchase_order
        @boosket_session = BoosketAPI::Session.new({:server => "localhost:3000", 
          :key => "35b6cfb2db59a976e0e3504fc6a9df"})
        o = BoosketAPI::Services::Order.find(15)
        o.status = "the stauts"
        o.transaction_status = "COMPLETED"
        o.transaction_id = "AZEAZE"
        o.transaction_date = Time.now
        o.save
        pp(o)
      end

    end
  end
end