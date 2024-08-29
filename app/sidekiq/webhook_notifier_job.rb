require 'net/http'
require 'uri'
require 'openssl'

class WebhookNotifierJob
  include Sidekiq::Job

  def perform(webhook_id, entry_id)
    webhook = Webhook.find(webhook_id)
    entry = Entry.find(entry_id)

    uri = URI.parse(webhook.url)
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = entry.to_json
    signature = generate_signature(request.body, webhook.secret_key)
    request["X-Signature"] = signature
    begin
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
        http.request(request)
      end
    rescue => e
      Rails.logger.error "Failed to send webhook: #{e.message}"
    end
  end

  private

  def generate_signature(payload, secret_key)
    OpenSSL::HMAC.hexdigest("SHA256", secret_key, payload)
  end
end
