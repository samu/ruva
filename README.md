# Ruva

Gwen Stefani would say: under construction!

# What?

Ruva is a simple utility to write conditions in a human readable manner.

Assume you have an object called `person` with an attribute `age = 23`:

    person = OpenStruct.new
    person.age = 23

You write 

	person.if "age is 23" do 
	  stuff
	end

You can also define more complex conditions:

    any
      name matches samuel
      all
        city matches zurich
        profession matches /application engineer/
        age is greater than or equal to 18      

The according ruby syntax would look something like this:

    (person.name =~ /samuel/) ||
    (person.city =~ /zurich/ && person.profession =~ /application engineer/ && person.age >= 18)

# How?

## Inline definition

As in the example above you can define a short condition on one line:

    person.if "name matches daniel or jonas" do
      stuff
    end.else do
      other_stuff
    end

You can also define larger conditions:

    person.if "
      any
        name matches lisa or simon or samuel
        age is between 18 and 28
        city matches zurich or /st. gallen/
    " do
      stuff
    end

The above definition says, that the condition is met if any of the three conditions defined under the 
`any` keyword meet.

Currently supported are the keywords `all`, `any` and `none`.

## Separate definition

You can define the same condition in a file with ".ruva" as extension:

    any
      name matches lisa or simon or samuel
      age is between 18 and 28
      city matches zurich or /st. gallen/

Then you load it:

    condition = Ruva.read "your_condition.ruva"

At this point, ruva loads the condition into some kind of hirarchy, according to the 
[Specification pattern](http://en.wikipedia.org/wiki/Specification_pattern), and you can invoke its 
`evaluate` method to test any object you want against that condition:

    result = condition.evaluate(your_input)

## Expressions

Expression                                              | Numerics | Strings  | Dates    | Booleans
------------------------------------------------------- | -------- | -------- | -------- | --------
`identifier is comparable`                              | yes      | yes      | yes      | true
























