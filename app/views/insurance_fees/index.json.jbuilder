json.array!(@insurance_fees) do |insurance_fee|
  json.extract! insurance_fee, :duration_from, :duration_to, :percentual
  json.url insurance_fee_url(insurance_fee, format: :json)
end
