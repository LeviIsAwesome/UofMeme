json.partial! "comments/comment", comment: @comment
json.extract! @comment, :id, :commenter , :created_at, :updated_at