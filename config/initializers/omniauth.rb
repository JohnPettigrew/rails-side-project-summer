Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.credentials.TWITTER_API_KEY, Rails.application.credentials.TWITTER_API_SECRET
end
