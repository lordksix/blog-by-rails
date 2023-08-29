require 'rails_helper'

RSpec.describe 'Index page', type: :system do
  before(:each) do
    @user = User.create(
      name: 'Max',
      bio: 'Full-stack developer',
      photo: 'https://placehold.co/200x200',
      post_counter: 0
    )

    @user_two = User.create(
      name: 'Jim',
      bio: 'Hiring Manager',
      photo: 'https://placehold.co/200x200',
      post_counter: 0
    )
  end

  describe 'index page' do
    it 'shows the right content' do
      visit users_path
      expect(page).to have_content('Max')
      expect(page).to have_content('Jim')
    end

    it 'should have the profile picture' do
      visit users_path
      expect(page).to have_xpath("//img[contains(@src,'https://placehold.co/200x200')]")
      expect(page).to have_xpath("//img[contains(@src,'https://placehold.co/200x200')]")
    end

    it 'should redirect to users show page' do
      visit user_path(@user.id)
      expect(page).to have_content('Max')
      expect(page).to have_content('Full-stack developer')
    end

    it 'should have number of users post' do
      visit users_path
      expect(page).to have_content('Number of posts: 0')
    end
  end
end
