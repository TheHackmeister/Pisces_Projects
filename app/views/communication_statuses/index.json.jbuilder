json.array!(@communication_statuses) do |communication_status|
  json.extract! communication_status, :id, :text, :val
  json.url communication_status_url(communication_status, format: :json)
end
