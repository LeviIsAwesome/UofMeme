json.partial! "posts/post", post: @post
json.extract! @post, :id, :poster, :description, :user_id, :file_name, :image, :uploaded_image_for_io_adapters, :created_at, :updated_at