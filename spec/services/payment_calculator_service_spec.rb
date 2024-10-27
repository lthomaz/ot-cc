require "rails_helper"

RSpec.describe PaymentCalculatorService, type: :service do
  subject(:service) { described_class.new(pay_rate: pay_rate, clients_amount: clients_amount) }

  describe "#call" do
    subject { service.call }

    context "without a pay_rate_bonus" do
      let(:pay_rate) { create(:pay_rate, base_rate_per_client: 5.0, pay_rate_bonus: nil) }
      let(:clients_amount) { 30 }

      it "calculates based on base_rate_per_client" do
        # (30*5) 150.0 + 0.0 bonus
        expect(subject).to eq(150)
      end
    end

    context "with a pay_rate_bonus" do
      let(:pay_rate) { create(:pay_rate, base_rate_per_client: 5.0, pay_rate_bonus: pay_rate_bonus) }
        let(:pay_rate_bonus) { build(:pay_rate_bonus, rate_per_client: 3.0, min_client_count: min_client_count, max_client_count: max_client_count) }

      context "with a min_client_count and without max_client_count" do
        let(:min_client_count) { 25 }
        let(:max_client_count) { nil }
        let(:clients_amount) { 30 }

        it "calculates base payment value + bonus" do
          # (30*5) 150.0 + (5*3) 15.0 bonus
          expect(subject).to eq(165.0)
        end

        context "and clients_amount does not achieves the minimum" do
          let(:min_client_count) { 25 }
          let(:max_client_count) { nil }
          let(:clients_amount) { 15 }

          it "calculates base payment value + bonus" do
            # (15*5) 75.0 + 0.0 bonus
            expect(subject).to eq(75)
          end
        end
      end

      context "with a min_client_count and with max_client_count" do
        context "and clients_amount does not exceed max" do
          let(:min_client_count) { 25 }
          let(:max_client_count) { 40 }
          let(:clients_amount) { 30 }

          it "calculates base payment value + bonus" do
            # (30*5) 150.0 + (5*3) 15.0 bonus
            expect(subject).to eq(165.0)
          end
        end

        context "and clients_amount does not exceed max" do
          let(:min_client_count) { 25 }
          let(:max_client_count) { 40 }
          let(:clients_amount) { 45 }

          it "calculates base payment value + bonus" do
            # (45*5) 225.0 + (15*3) 45.0 bonus
            expect(subject).to eq(270)
          end
        end
      end

      context "without a min_client_count and with max_client_count" do
        context "and clients_amount does not exceed max" do
          let(:min_client_count) { nil }
          let(:max_client_count) { 3 }
          let(:clients_amount) { 20 }

          it "calculates base payment value + bonus" do
            # (20*5) 100.0 + (3*3) 9.0 bonus
            expect(subject).to eq(109.0)
          end
        end
      end
    end
  end
end
