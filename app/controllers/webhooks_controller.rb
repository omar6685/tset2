class WebhooksController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    endpoint_secret = 'whsec_49bcygiLavzBn6yvUKLSMY4XN0onuKcy'
    
    set :port, 4242
    
    post '/webhook' do
        payload = request.body.read
        sig_header = request.env['HTTP_STRIPE_SIGNATURE']
        event = nil
    
        begin
            event = Stripe::Webhook.construct_event(
                payload, sig_header, endpoint_secret
            )
        rescue JSON::ParserError => e
            # Invalid payload
            status 400
            return
        rescue Stripe::SignatureVerificationError => e
            # Invalid signature
            status 400
            return
        end
    
        # Handle the event
        puts "Unhandled event type: #{event.type}"
    
        status 200
    end}
  end
end
