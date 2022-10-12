# Microposts App

Twitter like microposts application.

## Versions
- Ruby: 3.0.2
- Rails: 7.0.4

## Installation Steps
Clone the project
```bash
  git clone https://github.com/aalpturkay/rails-microposts-app.git
  cd rails-microposts-app
```
You need to set postgresql for your system's user and config your config/database.yml file with your credentials.

Install gem dependencies and set your db as follows
```bash
  bundle install
  rails db:create
  rails db:migrate
  rails db:seed
```

Run test cases
```bash
  rails test
```

Run the app with
```bash
  rails s
```
