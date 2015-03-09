Fabricator(:author) do
  name { Faker::Name.name }
  password { Faker::Lorem.word }
  username { Faker::Lorem.word }
end
