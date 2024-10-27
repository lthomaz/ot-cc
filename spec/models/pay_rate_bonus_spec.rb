require 'rails_helper'

RSpec.describe PayRateBonus, type: :model do
  describe "associations" do
    it { should belong_to(:pay_rate) }
  end

  describe "validations" do
    it { should validate_presence_of(:rate_per_client) }

    describe "min_or_max_client_present" do
      it "must be invalid without both columns" do
        pay_rate = build(:pay_rate)
        pay_rate_bonus = build(:pay_rate_bonus, pay_rate: pay_rate, rate_per_client: 1, min_client_count: nil, max_client_count: nil)

        expect(pay_rate_bonus).to be_invalid
        expect(pay_rate_bonus.errors[:base]).to include("min_client_count or max_client_count must be present")
      end

      it "must valid with min and without max client count" do
        pay_rate = build(:pay_rate)
        pay_rate_bonus = build(:pay_rate_bonus, pay_rate: pay_rate, rate_per_client: 1, min_client_count: 10, max_client_count: nil)

        expect(pay_rate_bonus).to be_valid
      end

      it "must valid without min and with max client count" do
        pay_rate = build(:pay_rate)
        pay_rate_bonus = build(:pay_rate_bonus, pay_rate: pay_rate, rate_per_client: 1, min_client_count: nil, max_client_count: 10)

        expect(pay_rate_bonus).to be_valid
      end
    end
  end
end
