require './test/test_helper'

class PostTest < ActiveSupport::TestCase
def setup@ testImage = File.new("test/fixtures/files/test.png")

@ user = users(: user1)@ validPost = Post.new(poster: @user.username, image: @testImage, description: 'I love meme', user_id: @user.id)
end

test 'valid post'
do
  assert@ validPost.save
end

test 'invalid poster'
do
  post = Post.new(description: 'I love meme', user_id: @user.id)
assert_not post.save, 'Poster is missing'
post = Post.new(poster: '', description: 'I love meme', user_id: @user.id)
assert_not post.save, 'Poster cannot be empty string'
post = Post.new(poster: 'mememe', description: 'I love meme', user_id: @user.id)
assert_not post.save, 'Poster does not exist'
end

test 'invalid image'
do
  post = Post.new(poster: @user.username, description: 'I love meme', user_id: @user.id)
assert_not post.save, 'Image is missing'
post = Post.new(poster: @user.username, image: '', description: 'I love meme', user_id: @user.id)
assert_not post.save, 'Image cannot not be empty string'


#Image is not found
assert_raises(SystemCallError) do
    testImage = File.new("test/fixtures/files/memememe.jpg")
  post = Post.new(poster: @user.username, image: testImage, description: 'I love meme', user_id: @user.id)
end
assert_not post.save, 'Image is not found'


#Image path is invalid
assert_raises(SystemCallError) do
    testImage = File.new("adsfasdf")
  post = Post.new(poster: @user.username, image: testImage, description: 'I love meme', user_id: @user.id)
end
assert_not post.save, 'Image path is invalid'


#Image path is empty
assert_raises(SystemCallError) do
    testImage = File.new("")
  post = Post.new(poster: @user.username, image: testImage, description: 'I love meme', user_id: @user.id)
end
assert_not post.save, 'image path is empty'
end

test 'invalid description'
do
  post = Post.new(poster: @user.username, image: @testImage, user_id: @user.id)
assert_not post.save, 'description is missing'

post = Post.new(poster: @user.username, image: @testImage, description: '', user_id: @user.id)
assert_not post.save, 'description is empty string'
end

test 'invalid user_id'
do
  post = Post.new(poster: @user.username, image: @testImage, description: 'I love meme')
assert_not post.save, 'user_id is missing'

post = Post.new(poster: @user.username, image: @testImage, description: 'I love meme', user_id: '')
assert_not post.save, 'user_id cannot be empty string'

post = Post.new(poster: @user.username, image: @testImage, description: 'I love meme', user_id: 'IAMTRUMP')
assert_not post.save, 'user_id does not exist'
end

test 'do not save blank post'
do@ blank_post = Post.new
assert_not@ blank_post.save, 'should not be allowed to save blank post'
end
end