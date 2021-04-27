class Api::V1::ProvidersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, fallback: :exception

  def index
    respond_with Provider.all
  end

  def show
    respond_with provider
  end

  def create
    respond_with Provider.create!(provider_params)
  end

  def update
    respond_with provider.update!(provider_params)
  end

  def destroy
    respond_with provider.destroy!
  end

  private

  def provider
    @provider ||= Provider.find_by!(id: params[:id])
  end

  def provider_params
    params.require(:provider).permit(
      :name,
      :address,
      :country
    )
  end
end
