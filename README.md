# Important information

`config/secrets.yml` is untracked, so make sure you have it.

`config/database.yml` is untracked. Make sure you duplicate `config/database.yml.example` and then rename it `config/database.yml`. If `config/database.yml.example` gets lost, there will be problems.

Before testing merge and seed the test environment with these terminal commands:

```ruby
rake db:migrate RAILS_ENV=test
rake db:seed RAILS_ENV=test
```

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
`rake doc:app`.
