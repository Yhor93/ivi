class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include Languaje
  include Error
  include Pagy::Backend
end
