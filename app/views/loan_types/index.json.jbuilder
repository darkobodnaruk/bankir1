json.array!(@loan_types) do |loan_type|
  json.extract! loan_type, :name
  json.url loan_type_url(loan_type, format: :json)
end
