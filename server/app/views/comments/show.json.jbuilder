json.partial! "comments/comment", comment: @comment
json.extract! @comment, :id, :comment, :commenter , :created_at, :updated_at