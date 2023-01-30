require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  before(:each) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @first_post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')
    @comment = Comment.create(post: @first_post, author: @user, text: 'Hi Tom!')
  end
  it 'can display the post title' do
    visit user_post_path(@user, @first_post)
    expect(page).to have_content('Hello')
  end
  it 'can display who wrote the post' do
    visit user_post_path(@user, @first_post)
    expect(page).to have_content('Tom')
  end
  it 'can display the number of comments' do
    visit user_post_path(@user, @first_post)
    expect(page).to have_content('1 Comments')
  end
  it 'can display the number of likes' do
    visit user_post_path(@user, @first_post)
    expect(page).to have_content('0')
  end
  it 'can display the body of the post' do
    visit user_post_path(@user, @first_post)
    expect(page).to have_content('This is my first post')
  end
  it 'can display the commentor & the comment' do
    visit user_post_path(@user, @first_post)
    expect(page).to have_content('Tom: Hi Tom!')
  end
end
