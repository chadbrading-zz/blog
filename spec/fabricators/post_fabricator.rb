Fabricator(:post, aliases: [:unpublished_post]) do
  author
  content { LoremIpsum.lorem_ipsum(paragraphs: 3) }
  title { Faker::Lorem.sentence }
  published  false
end

Fabricator(:published_post, from: :post) do
  published true
end
