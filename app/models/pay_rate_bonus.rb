class PayRateBonus < ApplicationRecord
  belongs_to :pay_rate

  validates :rate_per_client, :min_client_count, presence: true
end
