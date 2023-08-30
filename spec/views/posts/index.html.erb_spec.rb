require 'rails_helper'

RSpec.describe 'User Post Index page', type: :system do
  before(:each) do
    @user_one = User.create(
      name: 'Max',
      bio: 'Full-stack developer',
      photo: 'https://placehold.co/200x200',
      email: 'email@email.com',
      password: 'abcdef'
    )

    @user_two = User.create(
      name: 'Jim',
      bio: 'Hiring Manager',
      photo: 'https://placehold.co/190x190',
      email: 'email1@email.com',
      password: 'abcdef'
    )

    @post_one = @user_one.posts.create(title: 'Post 1', text: 'Lorem ipsum')
    @post_two = @user_one.posts.create(title: 'Post 2', text: 'Dolor sit amet')
    @comment = Comment.create(text: 'comment 1', author: @user_two, post: @post_one)
  end

  describe 'index page' do
    it 'shows the right username' do
      visit user_posts_path(user_id: @user_one.id)
      expect(page).to have_content(@user_one.name)
    end

    it 'shows the right username' do
      visit user_posts_path(user_id: @user_two.id)
      expect(page).to have_content(@user_two.name)
    end

    it 'should have the profile picture user one' do
      visit user_posts_path(user_id: @user_one.id)
      expect(page).to have_xpath("//img[contains(@src,'https://placehold.co/200x200')]")
    end

    it 'should have the profile picture user two' do
      visit user_posts_path(user_id: @user_two.id)
      expect(page).to have_xpath("//img[contains(@src,'https://placehold.co/190x190')]")
    end

    it 'should have number of posts by user one' do
      visit user_posts_path(user_id: @user_one.id)
      expect(page).to have_content('Number of posts: 2')
    end

    it 'should have number of posts by user two' do
      visit user_posts_path(user_id: @user_two.id)
      expect(page).to have_content('Number of posts: 0')
    end
  end

  it 'displays post information on the User post index page' do
    visit user_posts_path(user_id: @user_one.id)

    expect(page).to have_content(@post_one.title)
    expect(page).to have_content(@post_one.text)
    expect(page).to have_content(@post_two.title)
    expect(page).to have_content(@post_two.text)
    expect(page).to have_content(@user_two.name)
    expect(page).to have_content(@comment.text)
    expect(page).to have_content('Likes: 0')
    expect(page).to have_content('Comments: 1')
    expect(page).to have_content('Pagination')
  end

  it 'redirects to post show page when clicking on a post' do
    visit user_posts_path(user_id: @user_one.id)
    find("a[id='user-#{@user_one.id}-post-#{@post_one.id}']").click

    sleep(2)
    current_path
    expect(current_path).to eq(user_post_path(user_id: @user_one.id, id: @post_one.id))
  end
end
