class PayRateBonus < ApplicationRecord
  belongs_to :pay_rate

  validates :rate_per_client, presence: true
  validate :min_or_max_client_present?

  def min_or_max_client_present?
    if %w[min_client_count max_client_count].all? { |attr| self[attr].blank? }
      errors.add :base, "min_client_count or max_client_count must be present"
    end
  end
end
