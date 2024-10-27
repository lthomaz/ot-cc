require 'rails_helper'

RSpec.describe "PayRates", type: :request do
  describe "POST /pay_rates" do
    context "with valid parameters" do
      context "without pay_rate_bonus attributes" do
        let(:valid_attributes) do
          { "pay_rate" => { "rate_name" => "My rate", "base_rate_per_client" => 5.0 } }
        end

        it "creates a new PayRate" do
          expect {
            post pay_rates_url, params: valid_attributes, as: :json
          }.to change(PayRate, :count).by(1)
        end

        it "renders a JSON response with the new pay_rate" do
          post pay_rates_url,
              params: valid_attributes, as: :json
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end

      context "with pay_rate_bonus attributes" do
        let(:valid_attributes) do
          {
            "pay_rate" => {
              "rate_name" => "My rate",
              "base_rate_per_client" => 5.0,
              "pay_rate_bonus_attributes" => {
                "rate_per_client" => 3,
                "min_client_count" => 20
              }
            }
          }
        end

        it "creates a new PayRate" do
          expect {
            post pay_rates_url, params: valid_attributes, as: :json
          }.to change(PayRate, :count).by(1)
        end

        it "creates a new PayRateBonus" do
          expect {
            post pay_rates_url, params: valid_attributes, as: :json
          }.to change(PayRateBonus, :count).by(1)
        end

        it "renders a JSON response with the new pay_rate" do
          post pay_rates_url,
              params: valid_attributes, as: :json
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { "pay_rate" => { "rate_name" => "" } } }

      it "does not create a new PayRate" do
        expect {
          post pay_rates_url, params: invalid_attributes, as: :json
        }.to change(PayRate, :count).by(0)
      end

      it "renders a JSON response with errors for the new PayRate" do
        post pay_rates_url, params: invalid_attributes, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /pay_rates/:pay_rate_id" do
    context "with valid parameters" do
      context "without pay_rate_bonus attributes" do
        let(:pay_rate) { create(:pay_rate, rate_name: "Initial name", base_rate_per_client: 3) }

        let(:new_attributes) {
          { rate_name: "My new name", base_rate_per_client: 6  }
        }

        it "renders a JSON response with the new pay_rate and correct http status" do
          patch pay_rate_url(pay_rate), params: new_attributes, as: :json

          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including("application/json"))
        end

        it "updates pay_rate with new values" do
          patch pay_rate_url(pay_rate), params: { "pay_rate" => new_attributes }, as: :json

          pay_rate.reload
          expect(pay_rate.rate_name).to eq(new_attributes[:rate_name])
          expect(pay_rate.base_rate_per_client).to eq(new_attributes[:base_rate_per_client])
        end
      end

      context "with pay_rate_bonus attributes" do
        let(:pay_rate) { create(:pay_rate, rate_name: "Initial name", base_rate_per_client: 3) }
        let(:pay_rate_bonus) { create(:pay_rate_bonus, pay_rate: pay_rate, rate_per_client: 2, min_client_count: 10, max_client_count: 20) }

        let(:new_attributes) do
          {
            "rate_name" => "My rate",
            "base_rate_per_client" => 5.0,
            "pay_rate_bonus_attributes" => {
              "id" => pay_rate_bonus.id,
              "rate_per_client" => 3,
              "min_client_count" => 20,
              "max_client_count" => 40
            }
          }.deep_symbolize_keys
        end

        it "renders a JSON response with the pay_rate and http status ok" do
          patch pay_rate_url(pay_rate), params: { "pay_rate" => new_attributes }, as: :json

          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including("application/json"))
        end

        it "updates pay_rate with new values" do
          patch pay_rate_url(pay_rate), params: { "pay_rate" => new_attributes }, as: :json

          pay_rate.reload
          expect(pay_rate.rate_name).to eq(new_attributes[:rate_name])
          expect(pay_rate.base_rate_per_client).to eq(new_attributes[:base_rate_per_client])
          expect(pay_rate.pay_rate_bonus.rate_per_client).to eq(new_attributes[:pay_rate_bonus_attributes][:rate_per_client])
        end
      end
    end

    context "with invalid parameters" do
      let(:pay_rate) { create(:pay_rate, rate_name: "Initial name", base_rate_per_client: 3) }

      let(:invalid_attributes) { { "pay_rate" => { "rate_name" => "" } } }

      it "renders a JSON response with errors for the new PayRate" do
        patch pay_rate_url(pay_rate), params: invalid_attributes, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
