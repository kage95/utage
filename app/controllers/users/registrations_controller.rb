class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: [:create]
  before_action :configure_account_update_parameters, only: [:update]

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[nickname comment avatar])
    end

    def configure_account_update_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: %i[nickname comment avatar])
    end

    def update_resource(resource, params)
      resource.update_without_current_password(params)
    end

    def after_update_path_for(_resource)
      user_path(@user)
    end
end
