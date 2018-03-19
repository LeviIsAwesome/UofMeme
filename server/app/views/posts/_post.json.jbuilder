json.extract! post, :id, :name, :description, :created_at, :updated_at
json.url comment_url(post, format: :json)
