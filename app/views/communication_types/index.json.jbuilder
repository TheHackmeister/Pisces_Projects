json.array!(@communication_types) do |communication_type|
  json.extract! communication_type, :id, :text, :val
  json.url communication_type_url(communication_type, format: :json)
end
