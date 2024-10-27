class PaymentCalculatorService
  def initialize(pay_rate:, clients_amount:)
    @pay_rate = pay_rate
    @pay_rate_bonus = pay_rate.pay_rate_bonus
    @clients_amount = clients_amount
  end

  def call
    base_payment_value + bonus_value
  end

  private

  attr_reader :pay_rate, :pay_rate_bonus, :clients_amount

  def base_payment_value
    pay_rate.base_rate_per_client * clients_amount
  end

  def bonus_value
    return 0 if pay_rate_bonus.nil?

    amount_with_bonus * pay_rate_bonus.rate_per_client
  end

  def amount_with_bonus
    return 0 if clients_amount < min_client_count

    cropped_amount = [ clients_amount, max_client_count ].min
    cropped_amount - min_client_count
  end

  def max_client_count
    pay_rate_bonus.max_client_count || clients_amount
  end

  def min_client_count
    pay_rate_bonus.min_client_count || 0
  end
end
