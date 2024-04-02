FactoryBot.define do
  factory :operator do
    name { Faker::Company.name }
  end
end
