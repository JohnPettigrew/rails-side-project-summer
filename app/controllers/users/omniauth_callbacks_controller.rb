# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  def twitter
    auth = request.env["omniauth.auth"]
    current_user.update_columns(twitter_key: auth["credentials"]["token"])
    current_user.update_columns(twitter_secret: auth["credentials"]["secret"])
    img = auth["extra"]["raw_info"]["profile_image_url_https"]
    img = img.sub! '_normal', '_200x200'
    current_user.update_columns(twitter_user_url: img)
    current_user.update_columns(uid: auth["extra"]["raw_info"]["id"])
    current_user.update_columns(provider: "twitter")
    flash[:notice]="Successfully connected your account to Twitter!"
    redirect_to user_path(current_user)
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  def passthru
    super
  end

  # GET|POST /users/auth/twitter/callback
  def failure
    super
  end

  # protected

  # The path used when OmniAuth fails
  def after_omniauth_failure_path_for(scope)
    super(scope)
  end
end
