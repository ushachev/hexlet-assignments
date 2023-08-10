require 'faker'

5.times do
  Task.create({
    name: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    status: 'new',
    creator: Faker::Name.name,
    performer: Faker::Name.name,
    completed: Faker::Boolean.boolean
  })
end
