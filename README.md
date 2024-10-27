# ot-cc

A simple project for payments calculation!

- Ruby version: 3.1.1
- Rails version: 7.2.1.1

## Setup instructions

```
bundle install
bundle exec rails db:create db:migrate
bundle exec rails s
```

Running specs:

```
bundle exec rspec
```

## API Endpoints

### POST: /pay_rates

Creates a new pay_rate and optionally a pay_rate_bonus!

Body example:

```
{
  "pay_rate": {
    "rate_name": "My rate",
    "base_rate_per_client": 5.0,
    "pay_rate_bonus_attributes": {
      "rate_per_client": 3.0,
      "min_client_count": 20,
      "max_client_count": 30
    }
  }
}
```

### PUT: /pay_rates/:pay_rate_id

Updates an existent pay_rate

### GET: /pay_rates/:pay_rate_id/payment?clients=999

Returns the payment value for some pay rate based on _clients_ parameter.
