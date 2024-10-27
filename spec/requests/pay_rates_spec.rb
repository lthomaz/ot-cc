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
end
