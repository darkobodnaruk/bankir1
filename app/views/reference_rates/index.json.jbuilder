json.array!(@reference_rates) do |reference_rate|
  json.extract! reference_rate, :name, :rate
  json.url reference_rate_url(reference_rate, format: :json)
end
