json.array!(@steps) do |step|
  json.extract! step, :id, :action, :note, :val, :step_status_id
  json.url step_url(step, format: :json)
end
