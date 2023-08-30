require 'rails_helper'

RSpec.describe 'Index page', type: :system do
  before(:each) do
    @user_one = User.create(
      name: 'Max',
      bio: 'Full-stack developer',
      photo: 'https://placehold.co/200x200',
      post_counter: 0
    )

    @user_two = User.create(
      name: 'Jim',
      bio: 'Hiring Manager',
      photo: 'https://placehold.co/190x190',
      post_counter: 0
    )

    @post_one = @user_one.posts.create(title: 'Post 1', text: 'Lorem ipsum')
    @post_two = @user_one.posts.create(title: 'Post 2', text: 'Dolor sit amet')
    @comment = Comment.create(text: 'comment 1', author: @user_two, post: @post_one)
  end

  describe 'index page' do
    it 'shows the right username' do
      visit user_posts_path(user_id: @user_one.id)
      expect(page).to have_content(@user_one.name)
      expect(page).to have_content(@user_two.name)
    end

    it 'should have the profile picture' do
      visit users_path
      expect(page).to have_xpath("//img[contains(@src,'https://placehold.co/200x200')]")
      expect(page).to have_xpath("//img[contains(@src,'https://placehold.co/190x190')]")
    end

    it 'should redirect to users show page user one' do
      visit user_path(@user_one.id)
      expect(page).to have_content('Max')
      expect(page).to have_content('Full-stack developer')
    end

    it 'should redirect to users show page user two' do
      visit user_path(@user_two.id)
      expect(page).to have_content(@user_two.name)
      expect(page).to have_content(@user_two.bio)
    end

    it 'should have number of posts' do
      visit users_path
      expect(page).to have_content('Number of posts: 2')
      expect(page).to have_content('Number of posts: 0')
    end
  end
end
