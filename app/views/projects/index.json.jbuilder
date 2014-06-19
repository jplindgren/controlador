json.array!(@projects) do |project|
  json.extract! project, :id, :name, :description, :start, :prevision, :user_id
  json.url project_url(project, format: :json)
end
