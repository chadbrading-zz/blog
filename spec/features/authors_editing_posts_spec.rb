require 'rails_helper'

describe 'authors editing posts' do
  let!(:author) { Fabricate(:author, password: 'password') }
  let!(:post) { Fabricate(:post, author_id: author.id) }

  before(:each) do
    login(author)
  end

  it 'can edit a post' do
    expect(page).to have_content(post.content)
    click_link 'Edit post'
    fill_in 'Content', with: 'test'
    click_on 'Update post'
    expect(page).to have_content('test')
  end

  it 'can delete a post' do
    click_link 'Delete post'
    expect(page).not_to have_content(post.content)
  end

  it 'can add a post' do
    click_link 'Add post'
    fill_in 'Title', with: 'title of post'
    fill_in 'Content', with: 'new post'
    choose('published')
    click_on 'Create post'
    expect(page).to have_content('new post')
  end

  it 'can only see published posts from other authors' do
    author2 = Fabricate(:author)
    post2 = Fabricate(:post, author_id: author2.id, published: false)
    visit '/'
    expect(page).not_to have_content(post2.title)
  end
end
