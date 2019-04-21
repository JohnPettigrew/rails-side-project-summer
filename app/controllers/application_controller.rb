class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def hello
    render html: "If you're seeing this, something has gone badly wrong!"
  end

  protected

  # Check http://devise.plataformatec.com.br/#strong-parameters for more details on configuring the below
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, project_attributes: [:name, :description, :source] ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, project_attributes: [:name, :description, :source] ])
  end
end
