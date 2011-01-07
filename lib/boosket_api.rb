require 'digest/md5'
require 'base64'
require 'rubygems'
require 'tempfile'
require 'nokogiri'
require 'active_resource'
require 'uri'
require "cgi"
require 'net/http'

module BoosketAPI
  autoload :Version, "boosket_api/version"
  autoload :Base, "boosket_api/base"
  autoload :Session, "boosket_api/session"
  module Model
    autoload :Navigation, "boosket_api/model/navigation"
    autoload :Axe, "boosket_api/model/axe"
    autoload :Tag, "boosket_api/model/tag"
    autoload :Product, "boosket_api/model/product"
    autoload :Combination, "boosket_api/model/combination"
    autoload :Attribute, "boosket_api/model/attribute"
  end
  module Services
    attr_accessor :session
    autoload :Shop, "boosket_api/services/shop"
    autoload :Navigation, "boosket_api/services/navigation"
    autoload :Products, "boosket_api/services/products"
    autoload :Product, "boosket_api/services/product"
    autoload :Orders, "boosket_api/services/orders"
    autoload :Order, "boosket_api/services/orders"
    def self.session
      @@session
    end
    def self.session=(session)
      @@session = session
    end
  end
end
