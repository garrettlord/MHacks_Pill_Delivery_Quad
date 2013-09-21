json.array!(@requests) do |request|
  json.extract! request, :user_id, :hospital_id, :destination_id, :time_requested
  json.url request_url(request, format: :json)
end
