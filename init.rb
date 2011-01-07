require 'boosket_api'
boosket_config = YAML.load_file("#{RAILS_ROOT}/config/boosket.yml")[Rails.env]
BOOSKET_SESSION = BoosketAPI::Session.new({:server => boosket_config["server"], :key => boosket_config["key"]})