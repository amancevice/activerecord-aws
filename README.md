# AWS Helpers for ActiveRecord

## Installation

Add this line(s) to your application's Gemfile:

```ruby
gem 'activerecord-aws' github:'amancevice/activerecord-aws',
                       require:'active_record/aws',
                       tag:'<version>'
```

And then execute:

```bash
bundle
```

## Usage

Currently the only helper is a tool to use encrypted passwords in your `database.yml` files.

Instead of providing a `password` key in a configuration definition, use `ciphertext`:

```yaml
production:
  adapter:  mysql
  ciphertext: AQECAHhXdRbgz8ljDIWpU514phvxVx75R6f+A9VIrWvHZln/eQAAAGYwZAYJKoZIhvcNAQcGoFcwVQIBADBQBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDFKcRENqOdZFCUiVKQIBEIAjBi2ABQVzw9gjJUJCE0DBGoE0cQMgJfBZsnuRCjZl4G0Jc70=
  database: production
  host:     localhost
  port:     3306
  username: produser
```

Then, add the following line to your `Rakefile`:

```ruby
ActiveRecord::Base.decrypt_password if ActiveRecord::Base.encrypted_password?
```
