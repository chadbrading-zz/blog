require 'rails_helper'

describe Author do
  let(:author) { Author.new(name:'John Thomas') }

  it 'is valid' do
    expect(author).to be_valid
  end

  it 'is invalid without a name' do
    author.name = nil
    expect(author).not_to be_valid
  end
end
