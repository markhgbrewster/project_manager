# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :permit_sign_up_params, if: :devise_controller?

  private

  def permit_sign_up_params
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[
        first_name
        last_name
        email
        password
        password_confirmation
      ]
    )
  end
end
