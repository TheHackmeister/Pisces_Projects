json.array!(@contacts) do |contact|
  json.extract! contact, :id, :name, :phone, :email, :address, :references
  json.url contact_url(contact, format: :json)
end
