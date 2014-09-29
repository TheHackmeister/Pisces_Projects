json.array!(@project_links) do |project_link|
  json.extract! project_link, :id, :Project_id, :sort, :name, :url
  json.url project_link_url(project_link, format: :json)
end
