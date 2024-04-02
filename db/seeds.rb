# Operators
silver_tours_operator = Operator.find_or_create_by!(name: "Silver Tours")
golden_tours_operator = Operator.find_or_create_by!(name: "Golden Tours")

# Tours
safari_tour = Tour.find_or_create_by!(name: "Desert Dunes Safari", operator: silver_tours_operator)
sunset_tour = Tour.find_or_create_by!(name: "Desert Sunset Tour", operator: silver_tours_operator)
observation_tour = Tour.find_or_create_by!(name: "Marina Bay Sands Observation", operator: golden_tours_operator)
cruise_tour = Tour.find_or_create_by!(name: "River Cuise", operator: golden_tours_operator)

# Calendars
# Tour available every Monday starting from May 1st, 2024
Schedule.find_or_create_by!(
  tour: safari_tour,
  available_from: '2024-05-01',
  length: 2,
  day_of_week: 1,
  day_of_week_index: 0,
  recurring: true
)

# Tour available every second Tuesday of the month starting from May 1st, 2024
Schedule.find_or_create_by!(
  tour: sunset_tour,
  available_from: '2024-05-01',
  length: 7,
  day_of_week: 2,
  day_of_week_index: 2,
  recurring: true
)

# Tour available every Tuesday from Apr 1st, 2024 until Apr 30, 2024
Schedule.find_or_create_by!(
  tour: observation_tour,
  available_from: '2024-04-01',
  available_until: '2024-04-30',
  length: 7,
  day_of_week: 2,
  day_of_week_index: 0,
  recurring: true
)

# Tour available every Thursday from May 1st, 2024 until May 31, 2024
Schedule.find_or_create_by!(
  tour: observation_tour,
  available_from: '2024-05-01',
  available_until: '2024-05-31',
  length: 1,
  day_of_week: 4,
  day_of_week_index: 0,
  recurring: true
)

# Tour available on Apr 5th, 2024
Schedule.find_or_create_by!(
  tour: cruise_tour,
  available_from: '2024-04-05',
  length: 1,
  recurring: false
)

# Tour available on May 14th, 2024
Schedule.find_or_create_by!(
  tour: cruise_tour,
  available_from: '2024-05-14',
  length: 1,
  recurring: false
)

# Tour available on May 30th, 2024
Schedule.find_or_create_by!(
  tour: cruise_tour,
  available_from: '2024-05-30',
  length: 2,
  recurring: false
)
