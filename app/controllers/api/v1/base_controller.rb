class Api::V1::BaseController < Api::BaseController
  respond_to :json
  protect_from_forgery with: :null_session
  before_action do
    self.namespace_for_serializer = ::Api::V1
  end
end
