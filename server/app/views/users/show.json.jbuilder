json.partial! "users/user", user: @user
json.extract! @user, :id, :username, :email, :password, :password_confirmation, :created_at, :updated_at
