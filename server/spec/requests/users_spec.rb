require 'rails_helper'

RSpec.describe "Users", type: :request do
  # initialize test data 

  # subject {described_class.new(username: "user", email: "user@myumanitoba.ca", password: "12345678", password_confirmation: "12345678")}
  user2 = User.new(username: "user", email: "user@myumanitoba.ca", password: "12345678", password_confirmation: "12345678")



  # Build a User instance and override the email property
  # let(:user) {
  # 	# FactoryGirl.build(:user, email: '123', sign_in_count: 2)
  # 	FactoryBot.build(:user, username: "user", email: "user@myumanitoba.ca", password: "12345678", password_confirmation: "12345678")
  # }
  
  let!(:users) { FactoryBot.create_list(user2, 10) }
  let(:user_id) { users.first.id }

  describe "GET /users" do
  	# make HTTP get request before each example
  	before { get '/users' }

    it 'returns users' do
       # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end 
  end

  # Tests for GET /users/:id
  describe 'GET /users/:id' do
    before { get "/users/#{user_id}" }

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for PUT /users/:id
  describe 'PUT /users/:id' do
    let(:valid_attributes) { { username: 'notabot', password: 'password', password_confirmation: 'password', email: 'email@domain.ca' } }

    context 'when the record exists' do
      before { put "/users/#{user_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /users/:id' do
    before { delete "/users/#{post_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end


  # Test suite for POST /users
  describe 'POST /users' do
    # valid payload
    let(:valid_attributes) { { username: 'notabot', password: 'password', password_confirmation: 'password', email: 'email@domain.ca' } }

    context 'when the request is valid' do
      before { post '/users', params: valid_attributes }

      it 'creates a user' do
        expect(json['username']).to eq('notabot')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/users', params: { username: 'another_user' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: password, email, etc. can't be blank/)
      end
    end
  end




end
