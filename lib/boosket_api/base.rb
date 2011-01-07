module BoosketAPI
  class Base < ActiveResource::Base
    self.site = BoosketAPI::Services.session.site
  end
end