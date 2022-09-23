
require 'json'
require 'sinatra'
require 'stripe'

Stripe.api_key = 'sk_test_51LZDGTCd3RiW6igw7nTD6ACu87FKxGZhYlFmxGmp4ZN4LXggnpfdESHCTyjyvB0eLz5pJ6kNVa0hLR1Ng9jTHdse00WI2hbzaC'


# server.rb
#
# Use this sample code to handle webhook events in your integration.
#
# 1) Paste this code into a new file (server.rb)
#
# 2) Install dependencies
#   gem install sinatra
#   gem install stripe
#
# 3) Run the server on http://localhost:4242
#   ruby server.rb

require 'json'
require 'sinatra'
require 'stripe'

# This is your Stripe CLI webhook secret for testing your endpoint locally.
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
end