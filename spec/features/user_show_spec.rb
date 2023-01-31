require 'rails_helper'

RSpec.describe 'User', type: :feature do
  before(:each) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @first_post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')
    @second_post = Post.create(author: @user, title: 'Hello', text: 'This is my second post')
    @third_post = Post.create(author: @user, title: 'Hello', text: 'This is my third post')
    @fourth_post = Post.create(author: @user, title: 'Hello', text: 'This is my fourth post')
    @comment = Comment.create(post: @post, author: @user, text: 'Hi Tom!')
  end

  it 'can show the user\'s profile picture' do
    visit user_path(@user)
    expect(page).to have_selector("img[src='https://unsplash.com/photos/F_-0BxGuVvo']")
  end

  it 'can display the user\'s name' do
    visit user_path(@user)
    expect(page).to have_content('Tom')
  end

  it 'can display the number of posts for the user' do
    visit user_path(@user)
    expect(page).to have_content('Number of posts: 4')
  end

  it 'can show the user\'s bio' do
    visit user_path(@user)
    expect(page).to have_content('Teacher from Mexico.')
  end

  it 'shows only the first 3 posts' do
    visit user_path(@user)
    expect(page).to have_content('This is my first post')
    expect(page).to have_content('This is my second post')
    expect(page).to have_content('This is my third post')
    expect(page).not_to have_content('This is my fourth post')
  end

  it 'shows a button to see all posts' do
    visit user_path(@user)
    expect(page).to have_link('See all posts')
  end

  it 'redidrects to the user\'s post show page when the post is clicked' do
    visit user_path(@user)
    click_on 'See all posts'
    click_on 'This is my first post'
    expect(page).to have_current_path(user_post_path(@user, @first_post))
  end

  it 'redirects to the user\'s posts index page when the button is clicked' do
    visit user_path(@user)
    click_on 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
