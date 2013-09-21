json.array!(@users) do |user|
  json.extract! user, :hospital_id, :name, :phone_number, :priveledge
  json.url user_url(user, format: :json)
end
