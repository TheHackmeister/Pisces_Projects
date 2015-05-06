json.array!(@step_statuses) do |step_status|
  json.extract! step_status, :id, :text, :val
  json.url step_status_url(step_status, format: :json)
end
