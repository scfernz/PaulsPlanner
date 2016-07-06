json.array!(@tasks) do |task|
  json.extract! task, :id, :title, :description, :completed, :user_id, :created_by
  json.url task_url(task, format: :json)
end
