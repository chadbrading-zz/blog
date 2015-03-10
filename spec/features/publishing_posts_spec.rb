require 'rails_helper'
require 'sidekiq/testing'

describe 'publishing posts' do
  let!(:author) { Fabricate(:author, password: 'password') }

  before(:each) do
    login(author)
  end

  it 'can set a time to publish post' do
    click_link 'Add post'
    fill_in 'Title', with: 'new post tile'
    fill_in 'Content', with: 'new post content'
    select 'American Samoa', from: 'publish_time_time_zone'
    select '1:00 pm', from: 'publish_time_hour'
    select '2015-03-20', from: 'publish_time_date'
    click_on 'Create post'
    expect(Post.last.published).to eq(nil)
    Sidekiq::Testing.inline! do
      PublishPostWorker.drain
    end
    expect(Post.last.published).to eq(true)
  end
end
