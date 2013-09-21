json.array!(@hospitals) do |hospital|
  json.extract! hospital, :name, :latitude, :longitude
  json.url hospital_url(hospital, format: :json)
end
