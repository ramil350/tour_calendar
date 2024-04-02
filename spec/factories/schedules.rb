FactoryBot.define do
  factory :schedule do
    tour
    length { 5 }
    recurring { false }
    available_from { Date.tomorrow }

    trait :recurring do
      recurring { true }
      day_of_week { 2 }
      day_of_week_index { 3 }
    end
  end
end
