require "rails_helper"

RSpec.describe PayRate do
  describe "associations" do
    it { should have_one(:pay_rate_bonus) }
  end

  describe "validations" do
    it { should validate_presence_of(:rate_name) }
    it { should validate_presence_of(:base_rate_per_client) }
  end

  describe "#payment_value" do
    it "calls payment value calculator and returns value" do
      pay_rate = build(:pay_rate)
      payment_calculator_service = instance_double(PaymentCalculatorService)
      clients_amount = 20

      allow(PaymentCalculatorService).to receive(:new).with(pay_rate: pay_rate, clients_amount: clients_amount).and_return(payment_calculator_service)
      allow(payment_calculator_service).to receive(:call).and_return(199.99)

      expect(pay_rate.payment_value(clients_amount: clients_amount)).to eq(199.99)
    end
  end
end
