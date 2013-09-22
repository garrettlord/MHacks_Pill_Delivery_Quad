json.array!(@histories) do |history|
  json.extract! history, :copter_id, :hospital_id, :location_id, :time_left, :time_delivered, :time_returned
  json.url history_url(history, format: :json)
end
