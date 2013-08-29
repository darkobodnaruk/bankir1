json.array!(@appraisal_fees) do |appraisal_fee|
  json.extract! appraisal_fee, :duration_from, :duration_to, :percentual, :fixed_min, :fixed_max
  json.url appraisal_fee_url(appraisal_fee, format: :json)
end
