class PayRate < ApplicationRecord
  validates :rate_name, :base_rate_per_client, presence: true

  has_one :pay_rate_bonus
  accepts_nested_attributes_for :pay_rate_bonus

  def payment_value(clients_amount:)
    PaymentCalculatorService.new(pay_rate: self, clients_amount: clients_amount.to_i).call
  end
end
