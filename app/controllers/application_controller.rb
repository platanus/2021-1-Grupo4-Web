class ApplicationController < ActionController::Base
  include PowerTypes::Presentable
  before_action :authenticate_user!

end
