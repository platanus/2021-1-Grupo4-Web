# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def destroy
    sign_out current_user

    render json: {}, status: :ok
  end
end
