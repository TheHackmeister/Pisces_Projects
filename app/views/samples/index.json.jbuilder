json.array!(@samples) do |sample|
  json.extract! sample, :id, :customer_id, :pisces_id
  json.url sample_url(sample, format: :json)
end
