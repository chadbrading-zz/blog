require 'rails_helper'

describe 'authors editing posts' do
  let!(:author) { Fabricate(:author, password: 'password') }
  let!(:post) { Fabricate(:post, author_id: author.id) }

  before(:each) do
    login(author)
  end

  it 'can create a new post' do
    expect(page).to have_content(post.content)
    click_link 'Edit post'
    fill_in 'Content', with: 'test'
    click_on 'Update post'
    expect(page).to have_content('test')
  end
end
