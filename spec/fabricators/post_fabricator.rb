Fabricator(:post) do
  author_id
  content { LoremIpsum.lorem_ipsum(paragraphs: 3) }
  title { Faker::Lorem.sentence }
  published { rand(4) == 0 }
end
