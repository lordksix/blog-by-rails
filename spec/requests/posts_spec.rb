require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { User.create(name: 'John Doe', photo: nil, bio: nil, post_counter: 0) }
  let(:valid_attributes_user) { { name: 'John Doe', photo: nil, bio: nil, post_counter: 0 } }
  let(:post) { user.posts.create(title: 'Post Trial', text: 'Testing') }
  let(:valid_attributes_post) { { title: 'Post Trial', text: 'Testing' } }

  describe 'GET posts#index' do
    it 'returns http success' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(:success)
    end

    it 'should return success response' do
      temp = User.create! valid_attributes_user
      get "/users/#{temp.id}/posts"
      expect(response).to be_successful
    end

    it 'should render index template' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end

    it 'should include correct placeholder text in the response body' do
      temp = User.create! valid_attributes_user
      get "/users/#{temp.id}/posts"
      expect(response.body).to include('Post')
    end
  end

  describe 'GET posts#show' do
    it 'should return http success' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to have_http_status(:success)
    end

    it 'should return success response' do
      temp = user.posts.create! valid_attributes_post
      get "/users/#{user.id}/posts/#{temp.id}"
      expect(response).to be_successful
    end

    it 'should render show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
    end

    it 'should include correct placeholder text in the response body' do
      temp = user.posts.create! valid_attributes_post
      get "/users/#{user.id}/posts/#{temp.id}"
      expect(response.body).to include('Here are details for a given post')
    end
  end
end
