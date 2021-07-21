class Api::V1::ProvidersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, fallback: :exception

  def index
    respond_with providers.order(:name)
  end

  def show
    respond_with provider
  end

  def create
    respond_with providers.create!(provider_params)
  end

  def update
    respond_with provider.update!(provider_params)
  end

  def destroy
    respond_with provider.destroy!
  end

  private

  def provider
    @provider ||= providers.find_by!(id: params[:id])
  end

  def providers
    @providers ||= current_user.providers
  end

  def provider_params
    params.require(:provider).permit(
      :name,
      :address,
      :country,
      :email,
      :webpage_url,
      :phone,
      :minimum_purchase,
      :delivery_days,
      :contact_name,
      :contact_rut,
      :bank_name,
      :account_type,
      :account_number
    )
  end
end
