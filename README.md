# Ruva

[![Build Status](https://secure.travis-ci.org/ssmm/ruva.png)](http://travis-ci.org/ssmm/ruva)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/ssmm/ruva)

Write plain text conditions.

Assume you have an object called `person` with an attribute `age = 23`:

```ruby
person = OpenStruct.new
person.age = 23
```

You write

```ruby
person.if "age is 23" do
  stuff
end
```

You can also define more complex conditions:

    any
      name matches samuel
      all
        city matches zurich
        profession matches /application engineer/
        age is greater than or equal to 18

In plain ruby, the above condition translates to

```ruby
(person.name =~ /samuel/) ||
(person.city =~ /zurich/ && person.profession =~ /application engineer/ && person.age >= 18)
```

# Details

## Inline definition

### One liners

As in the example above you can define a short condition on one line:

```ruby
person.if "name matches daniel or jonas" do
  stuff
end
```

You can also define an else statement:

```ruby
person.if("name matches daniel or jonas") do
  stuff
end.else do
  other_stuff
end
```

Note that you have to put the condition into brackets in this case.

### Multiline

You may define larger conditions like this:

```ruby
person.if "
  any
    name matches daniel or jonas or samuel
    age is between 18 and 28
    city matches zurich or /new york/
" do
  stuff
end
```

The above definition says, that the condition is met if any of the three conditions defined under the
`any` keyword meet.

Currently supported are the keywords `all`, `any` and `none`.

## Separate definition

You can define the same condition in a file with ".ruva" as extension:

    any
      name matches daniel or jonas or samuel
      age is between 18 and 28
      city matches zurich or /new york/

Then you load it:

```ruby
condition = Ruva.read "your_condition"
```

At this point, ruva loads the condition into some kind of hirarchy, according to the
[Specification pattern](http://en.wikipedia.org/wiki/Specification_pattern), and you can invoke its
`evaluate` method to test any object you want against that condition:

```ruby
result = condition.evaluate(your_input)
```

## Expressions

#### is

    age is 20

Acts the same as the `==` operator.

#### is between

    age is between 20 and 30

Acts the same as [`between?`](http://www.ruby-doc.org/core-1.9.3/Comparable.html#method-i-between-3F).

#### is greater than (or equal to) / is less than (or equal to)

    age is greater than 18
    age is less than 18
    age is greater than or equal to 18
    age is less than or equal to 18

Acts the same as the `<, >, <=, >=` operators

#### matches

    city matches zurich
    city matches /new york/

Acts the same as the `=~` operator.

#### or / and

You can use `ors` and `ands` where it makes sense. For Example:

    name matches lisa or simon or samuel
    city matches z and u and r