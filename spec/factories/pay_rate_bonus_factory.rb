FactoryBot.define do
  factory :pay_rate_bonus do
    pay_rate
    rate_per_client  { 2.0 }
    min_client_count { 5 }
    max_client_count { 10 }
  end
end
