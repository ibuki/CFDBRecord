# CFDBRecord

This is a ruby gem to get data from Wordpress CFDB Plugin using ActiveRecord.

CFDB stores data as EAV to a table. It sometimes unuseful.

This library gather some records as a Submit object.

When you you set `userid` value to each Submit, you can also gather some submit as a User object.
This function may be useful when you creating a multi-step-form.

This plugin only tested with CF7 Plugin. I don't know if it works with the other form plugins.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cfdb_record', github: 'ibuki/CFDBRecord'
```

## Requirement

- Wordpress
- Mysql
- [CFDB plugin](https://github.com/mdsimpson/contact-form-7-to-database-extension)
- Ruby

## Usage

### Get Data From CFDB (Activerecord connection needed)

```ruby
require 'cfdb_record'

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: ENV['DB_HOSTNAME'],
  username: ENV['DB_USERNAME'],
  password: ENV['DB_PASSWORD'],
  database: ENV['DB_NAME']
)

submits = CFDBRecord::Submit.all
puts submits.first.attrs['username']

# User needs 'userid' attrs
users = CFDBRecord::User.all

# User.attrs shows the newest attr from submits which has the same 'userid'
puts users.first.attrs['username']
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
