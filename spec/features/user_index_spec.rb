require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'User', type: :feature do
  before(:each) do
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Mexico.')
    User.create(name: 'peter', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    Post.create(author: @first_user, title: 'Hello', text: 'This is my first post')
  end
  it 'can display user name' do
    visit '/users'
    expect(page).to have_content 'Tom'
    expect(page).to have_content 'peter'
  end
  it 'can display users photo' do
    visit '/users'
    expect(page).to have_selector("img[src*='https://unsplash.com/photos/F_-0BxGuVvo']")
  end
  it 'can display users posts number' do
    visit '/users'
    expect(page).to have_content 'Number of posts: 1'
  end
  it 'can redirected to that users show page' do
    visit '/users'
    click_link 'user_link'
    expect(page).to have_current_path(user_path(@first_user))
  end
end
