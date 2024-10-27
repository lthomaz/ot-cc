require 'rails_helper'

RSpec.describe PayRateBonus, type: :model do
  describe "associations" do
    it { should belong_to(:pay_rate) }
  end

  describe "validations" do
    it { should validate_presence_of(:rate_per_client) }
    it { should validate_presence_of(:min_client_count) }
  end
end
