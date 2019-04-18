class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render html: "If you're seeing this, something has gone badly wrong!"
  end
end
