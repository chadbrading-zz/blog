Fabricate(:author, username: 'test', password: 'password')
10.times do
  Fabricate(:author)
end

10.times do
  Fabricate(:post, author_id: rand(1..10))
end
