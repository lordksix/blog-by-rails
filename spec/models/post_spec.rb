require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'validates presence of title' do
    post = Post.new(title: nil)
    expect(post).to_not be_valid
  end

  it 'validates length of title' do
    post = Post.new(title: 'ab' * 126)
    expect(post).to_not be_valid
  end

  it 'validates comments_counter is greater than or equal to 0' do
    author = User.create!(name: 'Jane Doe', post_counter: 0)
    post = Post.new(author:, title: 'Title', comments_counter: -5)
    expect(post).to_not be_valid
  end

  it 'validates likes_counter is greater than or equal to 0' do
    author = User.create!(name: 'Jane Doe', post_counter: 0)
    post = Post.new(author:, title: 'Title', likes_counter: -5)
    expect(post).to_not be_valid
  end

  it 'increments the author posts_counter by 1' do
    author = User.create!(name: 'Jane Doe', post_counter: 0)
    post = Post.create!(author:, title: 'Title')
    expect { post.save! }.to change { author.reload.post_counter }.by(1)
  end

  it 'returns the five most recent comments' do
    author = User.create!(name: 'Jane Doe', post_counter: 0)
    post = Post.create!(title: 'Title', author:)
    older_comments = 6.times.map { Comment.create!(post:, text: 'Old comment', author:) }
    recent_comment = Comment.create!(post:, text: 'Recent comment', author:)

    expect(post.five_most_recent_comments).to include(recent_comment)
    expect(post.five_most_recent_comments.length).to eq(5)
    expect(post.five_most_recent_comments).to_not include(older_comments.first)
  end
end
