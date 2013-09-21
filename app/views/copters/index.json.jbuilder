json.array!(@copters) do |copter|
  json.extract! copter, :hospital_id, :name, :category, :last_latitude, :last_longitude, :available
  json.url copter_url(copter, format: :json)
end
