json.array!(@destinations) do |destination|
  json.extract! destination, :hospital_id, :name, :description, :latitude, :longitude
  json.url destination_url(destination, format: :json)
end
