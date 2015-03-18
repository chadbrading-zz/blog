require 'rails_helper'
require 'sidekiq/testing'

describe 'publishing posts' do
  let!(:author) { Fabricate(:author, password: 'password') }

  before do
    login(author)
  end

  around do |example|
    Sidekiq::Testing.inline! do
      example.run
    end
  end

  it 'can set a time to publish post' do
    click_link 'Add post'
    fill_in 'Title', with: 'new post tile'
    fill_in 'Content', with: 'new post content'
    select 'American Samoa', from: 'publish_time_time_zone'
    select '1:00 pm', from: 'publish_time_hour'
    select '2015-03-20', from: 'publish_time_date'
    click_on 'Create post'
    expect(Post.last).to be_published
    expect(Post.last.publish_time.to_s).to eq("2015-03-21 00:00:00 UTC")
  end
end
