json.array!(@medicines) do |medicine|
  json.extract! medicine, :hospital_id, :name, :type, :description, :restricted, :quantity
  json.url medicine_url(medicine, format: :json)
end
