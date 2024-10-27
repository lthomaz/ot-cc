FactoryBot.define do
  factory :pay_rate do
    rate_name { "My first rate" }
    base_rate_per_client  { 4.0 }
  end
end
