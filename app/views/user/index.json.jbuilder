json.array!(@meetings) do |meeting|
  json.extract! meeting, :id, :date, :location, :description, :created_by
  json.url meeting_url(meeting, format: :json)
end
