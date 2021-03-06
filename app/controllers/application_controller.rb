class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Sorry but you cannot perform that action."
    flash[:alert] += " Try logging in and trying again." if !user_signed_in?
  redirect_back fallback_location: root_url
end

  def hello
    render html: "If you're seeing this, something has gone badly wrong!"
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  protected

  # Check http://devise.plataformatec.com.br/#strong-parameters for more details on configuring the below
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, project_attributes: [:name, :description, :source] ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
