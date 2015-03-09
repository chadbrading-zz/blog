def login(author)
  visit '/'
  click_link('Sign in')
  fill_in 'Username', with: author.username
  fill_in 'Password', with: 'password'
  click_button 'Sign in'
end
