FactoryBot.define do
  factory :user do
  	username { Faker::Lorem.characters(30) }
  	email { Faker::Lorem.characters(30) }
  	password { Faker::Lorem.characters(30) }
  	password_confirmation { Faker::Lorem.characters(30) }
  end
end