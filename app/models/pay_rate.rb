class PayRate < ApplicationRecord
  validates :rate_name, :base_rate_per_client, presence: true

  has_one :pay_rate_bonus
  accepts_nested_attributes_for :pay_rate_bonus
end
