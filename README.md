# Validators

This gem contains validators for some commonly used fields like contact number. It implements the validations at the model level by creating concerns for the same.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'validators'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install validators

## Usage

Currently, only one validator has been added which validates contact numbers. The validator extends `ActiveSupport::Concern` and can be used by following two steps:

1. Include `Validators::ContactNumberValidator` in the model which contains the contact number field as `include Validators::ContactNumberValidator`
2. Specify the name of the column in which the contact number is stored as `contact_number_column_name <symbolic representation of the column name containing contact numbers>` <br/>
For example: `contact_number_column_name :contact_number` where `contact_number` is the name of the field that contains contact numbers.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Bizongo/validators.
