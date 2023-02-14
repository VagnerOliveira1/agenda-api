require 'httparty'
class SendNotificationJob < ApplicationJob
  queue_as :default

  def perform(id)
    contact = Contact.find(id)
    # send a notification to the webhook
    # example using HTTParty
    HTTParty.post(
      ENV['WEBHOOK_URL'],
      body: { name: contact.full_name, email: contact.email }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
  end
end
