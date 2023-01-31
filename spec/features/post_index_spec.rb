require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  before(:each) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @second_user = User.create(name: 'Peter', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                               bio: 'Teacher from Mexico.')
    @first_post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')
    @second_post = Post.create(author: @user, title: 'Hi', text: 'This is my second post')
    @third_post = Post.create(author: @user, title: 'Hi', text: 'This is my third post')
    @fourth_post = Post.create(author: @user, title: 'Hi', text: 'This is my fourth post')
    Comment.create(post: @first_post, author: @second_user, text: 'Hi Tom!')
  end

  it 'can show the user\'s profile picture' do
    visit user_posts_path(@user)
    expect(page).to have_selector("img[src='https://unsplash.com/photos/F_-0BxGuVvo']")
  end

  it 'can display the user\'s name' do
    visit user_posts_path(@user)
    expect(page).to have_content('Tom')
  end

  it 'can display the number of posts for the user' do
    visit user_posts_path(@user)
    expect(page).to have_content('Number of posts: 4')
  end

  it 'can display the post\'s title' do
    visit user_posts_path(@user)
    expect(page).to have_content('Hello')
    expect(page).to have_content('Hi')
  end

  it 'can display the post\'s body' do
    visit user_posts_path(@user)
    expect(page).to have_content('This is my first post')
    expect(page).to have_content('This is my second post')
    expect(page).to have_content('This is my third post')
  end

  it 'can display the first comment for the post' do
    visit user_posts_path(@user)
    expect(page).to have_content('Hi Tom!')
  end

  it 'can display the number of comments for the post' do
    visit user_posts_path(@user)
    expect(page).to have_content('comments: 1')
  end

  it 'can display pagination links if there are more than 3 posts' do
    visit user_posts_path(@user)
    expect(page).to have_selector('#pagination')
  end

  it 'can show how many likes the post has' do
    visit user_posts_path(@user)
    expect(page).to have_content('Likes: 0')
  end

  it 'can redirect to the post\'s show page' do
    visit user_posts_path(@user)
    click_on 'Hello'
    expect(page).to have_current_path(user_post_path(@user, @first_post))
  end
end
