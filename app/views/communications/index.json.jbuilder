json.array!(@communications) do |communication|
  json.extract! communication, :id, :summary, :notes, :communication_status_id, :communication_type_id, :project_id
  json.url communication_url(communication, format: :json)
end
