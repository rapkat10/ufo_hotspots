class Api::V01::BaseController < ActionController::Base
  protect_from_forgery with: :null_session
end
