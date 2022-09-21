module Phonei
  class Application < Rails::Application
    config.after_initialize do
      # initialization code goes here
      Stripe.api_key = Rails.application.credentials[:stripe][:secret]
    end
  end
end