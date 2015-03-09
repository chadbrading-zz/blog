require 'rails_helper'

describe Post do
  let(:post) { Post.new(author_id: 1, content: 'sample post') }

  it 'is valid' do
    expect(post).to be_valid
  end

  it 'is invalid without an author' do
    post.author_id = nil
    expect(post).not_to be_valid
  end

  it 'is invalid without content' do
    post.content = nil
    expect(post).not_to be_valid
  end
end
