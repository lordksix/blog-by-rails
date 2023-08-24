require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/comment/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/comment/create'
      expect(response).to have_http_status(:success)
    end
  end
end
