require 'rails_helper'

describe 'author logging in and out', type: :feature do
  context 'new author' do
    it 'can register' do
      count = Author.all.count
      visit '/'
      click_link ('Register')
      expect(current_path).to eq(new_author_path)
      fill_in 'Name', with: 'John Henry'
      fill_in 'Username', with: 'jhens'
      fill_in 'Password', with: 'password'
      click_button 'Register'
      expect(Author.all.count).to eq(count + 1)
    end
  end

  context 'existing author' do
    before(:each) do
      author = Author.create(name: 'John Henry', username: 'jhens', password: 'password')
    end

    it 'can login' do
      visit '/'
      click_link('Sign in')
      fill_in 'Username', with: 'jhens'
      fill_in 'Password', with: 'password'
      click_button 'Sign in'
    end

    it 'can logout' do
      visit '/'
      click_link('Sign in')
      fill_in 'Username', with: 'jhens'
      fill_in 'Password', with: 'password'
      click_button 'Sign in'

      click_link 'Sign out'
    end
  end
end
