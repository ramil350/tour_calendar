# README

## Getting Started

### Install and prepare DB
```
bundle install
bundle exec rake db:migrate
bundle exec rake db:seed
```

### Run test suite
```
bundle exec rspec
```

### Start Application
```
bundle exec rails s --port 3030
```

## Usage

### Search for available tours:
```
  http://localhost:3030/search?filter[start_date]=2024-04-01&filter[end_date]=2024-04-30
```

### Add a non-recurring schedule for a tour
```
curl --request POST 'http://localhost:3030/schedules' \
     --header 'Content-Type: application/json' \
     --data-raw '{
        "tour_id": "4",
        "available_from": "2024-06-01",
        "length": "3",
        "recurring": "false"
     }'
```

### Add a recurring schedule for a tour:
```
curl --request POST 'http://localhost:3030/schedules' \
     --header 'Content-Type: application/json' \
     --data-raw '{
        "tour_id": "4",
        "available_from": "2024-05-01",
        "available_until": "2024-05-31",
        "length": "2",
        "recurring": "true",
        "day_of_week": "4",
        "day_of_week_index": 2
     }'
```

## Notes

* Every schedule record represents a single availability type for a tour
* Tour can have as many schedule records as needed
* Tour length is specified in days
* We are dealing only with dates, time and time zones are not taken into account
* No authentication was yet implemented
