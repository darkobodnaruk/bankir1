json.array!(@loans) do |loan|
  json.extract! loan, :name
  json.url loan_url(loan, format: :json)
end
