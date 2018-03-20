require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:valid_attributes){
  	skip("Hash of valid_attributes")
  }

  let(:invalid_attributes){
  	skip("Hash of invalid_attributes")
  }

  let(:valid_session) { {} }

  describe "GET #new" do

    it "returns http success" do
      user = User.new! valid_attributes
      get :new, params: {}, session: valid_session
      expect(response).to have_http_status(:success)
    end
  end

end
