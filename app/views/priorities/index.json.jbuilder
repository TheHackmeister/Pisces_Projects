json.array!(@priorities) do |priority|
  json.extract! priority, :id, :text, :val
  json.url priority_url(priority, format: :json)
end
