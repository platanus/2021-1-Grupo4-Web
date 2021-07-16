class ApplicationController < ActionController::Base
  include PowerTypes::Presentable
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_session_path, flash: { error: 'no estas loggeado' }
    end
  end

  def forgot_password; end
end
