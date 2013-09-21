json.array!(@requested_medicines) do |requested_medicine|
  json.extract! requested_medicine, :request_id, :medicine_id, :quantity
  json.url requested_medicine_url(requested_medicine, format: :json)
end
