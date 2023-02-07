require 'httparty'
class SendNotificationJob < ApplicationJob
  queue_as :default

  def perform(id)
    contact = Contact.find(id)
    # send a notification to the webhook
    # example using HTTParty
    HTTParty.post(
      'https://webhook.site/671e68f8-d967-46ab-9992-4dc2598026b6',
      body: { name: contact.full_name, email: contact.email }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
  end
end
