require 'faker'

5.times do
  Post.create({
                 title: Faker::Lorem.sentence,
                 body: Faker::Lorem.paragraph,
                 summary: Faker::Lorem.sentence,
                 published: Faker::Boolean.boolean
               })
end
