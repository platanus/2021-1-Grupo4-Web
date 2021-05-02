class Api::V1::IngredientsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, fallback: :exception
  include Api::Error

  def search_ingredients
    base_result = []
    clients.each do |client|
      base_result += client.new.products_by_query(query: search_params[:query])
    end

    respond_with({ data: base_result })
  end

  private

  def clients
    [JumboClient]
  end

  def search_params
    params.permit(:query)
  end
end
