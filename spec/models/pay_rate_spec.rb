require "rails_helper"

RSpec.describe PayRate do
  describe "associations" do
    it { should have_one(:pay_rate_bonus) }
  end

  describe "validations" do
    it { should validate_presence_of(:rate_name) }
    it { should validate_presence_of(:base_rate_per_client) }
  end
end
