json.extract! recurring_task, :id, :name, :completed_at, :created_at, :updated_at
json.url recurring_task_url(recurring_task, format: :json)
