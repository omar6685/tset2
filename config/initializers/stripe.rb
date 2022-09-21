module Phonei
  class Application < Rails::Application
    config.after_initialize do
      # initialization code goes here
      if Rails.application.credentials[:stripe].present? && Rails.application.credentials[:stripe][:secret].present?
        Stripe.api_key = Rails.application.credentials[:stripe][:secret]
      end
    end
  end
end
