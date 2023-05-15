Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV.fetch('GOOGLE_OAUTH_CLIENTID', '1017266744995-k9heo6bk78idvi7qu9kvs0a6ntrfj1mg.apps.googleusercontent.com'), ENV.fetch('GOOGLE_OAUTH_SECRET', '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')
end