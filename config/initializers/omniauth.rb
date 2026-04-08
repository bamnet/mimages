# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           ENV.fetch('GOOGLE_OAUTH_CLIENTID'),
           ENV.fetch('GOOGLE_OAUTH_SECRET')
end
