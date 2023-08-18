require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#update_likes_counter' do
    it 'increments the post likes_counter by 1' do
      user = User.create!(name: 'John Doe', post_counter: 0)
      post = Post.create!(author: user, title: 'Title')
      like = Like.new(author: user, post:)
      expect(post.likes_counter).to eq 0
      like.save!
      post.reload
      expect(post.likes_counter).to eq 1
    end
  end
end
