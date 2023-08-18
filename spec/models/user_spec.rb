require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates presence of name' do
    user = User.new(name: nil)
    expect(user).to_not be_valid
  end

  it 'validates post_counter is greater than or equal to 0' do
    user = User.new(post_counter: -5)
    expect(user).to_not be_valid
  end

  it 'returns three most recent posts' do
    user = User.create!(name: 'Jane Doe', post_counter: 0)
    old_posts = 3.times.map { Post.create!(author: user, title: 'Old post', created_at: 2.day.ago) }
    new_posts = 3.times.map { Post.create!(author: user, title: 'New post') }
    expect(user.three_most_recent_posts).to eq new_posts.reverse
  end
end
