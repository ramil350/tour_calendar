FactoryBot.define do
  factory :tour do
    name { Faker::Locations::Australia.location }
    operator
  end
end
