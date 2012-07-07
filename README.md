# Ruva

## What

Ruva (_ru_ by e _va_ luation) is a simple utility to describe conditions in a human readable manner.

Assume you have an object called `person` with an attribute `age = 23`. 

    person = OpenStruct.new
    person.age = 23

You write 

    spec = RuvaExpression.parse "age is 23"
    result = spec.evaluate person 

and find out that your condition is `true`!

## How



## Installation

Add this line to your application's Gemfile:

    gem 'ruva'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruva

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
