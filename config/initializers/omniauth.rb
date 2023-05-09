Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '1017266744995-k9heo6bk78idvi7qu9kvs0a6ntrfj1mg.apps.googleusercontent.com', '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'
end