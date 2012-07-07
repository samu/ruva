# Ruva

## What

Ruva is a simple utility to describe conditions in a human readable manner.

Assume you have an object called `person` with an attribute `age = 23`:

    person = OpenStruct.new
    person.age = 23

You write 

    spec = RuvaExpression.parse "age is 23"
    condition = spec.evaluate person 

and find out that your condition is `true`!

You can also define more complex conditions:

    any
      name matches samuel
      all
        city matches zurich
        profession matches /application engineer/
        age is greater than or equal to 18      
        
This expression says that (`name` of `person` matches /samuel/) __or__ that (`city` 
matches /zurich/ __and__ `profession` matches /application engineer/ __and__ `age` is 
greater than or equal to 18).


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
