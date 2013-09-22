json.array!(@copters) do |copter|
  json.extract! copter, :hospital_id, :name, :type, :last_latitude, :last_longitude, :available
  json.url copter_url(copter, format: :json)
end
