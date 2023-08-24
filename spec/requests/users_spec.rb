require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET users#index' do
    it 'returns http success' do
      get '/users'
      expect(response).to have_http_status(:success)
    end

    it 'should return success response' do
      get '/users'
      expect(response).to be_successful
    end

    it 'should render index template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'should include correct placeholder text in the response body' do
      get '/users'
      expect(response.body).to include('User')
    end
  end

  describe 'GET users#show' do
    let(:user) { User.create(name: 'John Doe', photo: nil, bio: nil, post_counter: 0) }
    let(:valid_attributes) { { name: 'John Doe', photo: nil, bio: nil, post_counter: 0 } }

    it 'should return http success' do
      get "/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end

    it 'should return success response' do
      temp = User.create! valid_attributes
      get user_url(temp)
      expect(response).to be_successful
    end

    it 'should render show template' do
      get user_url(user)
      expect(response).to render_template(:show)
    end

    it 'should include correct placeholder text in the response body' do
      temp = User.create! valid_attributes
      get "/users/#{temp.id}"
      expect(response.body).to include('Here are details for a given user')
    end
  end
end
