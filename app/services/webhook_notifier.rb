require 'net/http'
require 'uri'

class WebhookNotifier
  def self.notify(entry)
    webhooks = Webhook.where(enabled: true)
    webhooks.each do |webhook|
      uri = URI.parse(webhook.url)
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request.body = entry.to_json
      signature = generate_signature(request.body, webhook.secret_key)
      request["X-Signature"] = signature
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
        http.request(request)
      end
    end
  end

  private

  def self.generate_signature(payload, secret_key)
    OpenSSL::HMAC.hexdigest("SHA256", secret_key, payload)
  end
end