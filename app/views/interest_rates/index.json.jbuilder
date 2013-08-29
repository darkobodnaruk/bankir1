json.array!(@interest_rates) do |interest_rate|
  json.extract! interest_rate, :fixed, :duration_from, :duration_to, :bank_customer, :insured, :rate
  json.url interest_rate_url(interest_rate, format: :json)
end
