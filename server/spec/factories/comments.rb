FactoryBot.define do
  factory :comment do
    commenter { Faker::Lorem.characters(30) }
    post_id nil
  end
end