class Webhook < ApplicationRecord
  validates :url, presence: true, format: { with: URI::regexp(%w[http https]) }
  validates :secret_key, presence: true
  validates :enabled, inclusion: { in: [true, false] }
end
