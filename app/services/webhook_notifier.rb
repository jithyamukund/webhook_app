require 'net/http'
require 'uri'

class WebhookNotifier
  def self.notify(entry_id)
    webhooks = Webhook.where(enabled: true)
    webhooks.each do |webhook|
      WebhookNotifierJob.perform_async(webhook.id, entry_id)
    end
  end

end