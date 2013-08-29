json.array!(@banks) do |bank|
  json.extract! bank, :name
  json.url bank_url(bank, format: :json)
end
