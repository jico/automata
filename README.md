# Automata

A sweet Ruby gem for creating and simulating deterministic/nondeterministic finite automata, push-down automata, and Turing machines.

## Installation

Requires __Ruby 1.9.3__.

Add this line to your application's Gemfile:

    gem 'automata'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install automata

## Usage

### Creating a new machine

Defining a new machine can be done in two ways: 

* From a structured YAML file.
* Through class setter methods.

#### Building with YAML

We can easily define a machine's _n_-tuples in a YAML file. For example, let's create a DFA defined by the 5-tuple (_states_, _alphabet_, _start_, _accept_, _transitions_). We create the file `examples/dfa_sample.yml` with the following content:

    states:
      - A
      - B
      - C
      - D
    alphabet:
      - 0
      - 1
    start: A
    accept:
      - C
    transitions:
      A:
        0: B
        1: D
      B:
        0: C
        1: D
      C:
        0: C
        1: C
      D:
        0: D
        1: D

With our machine defined, we can create a new DFA object from the file.

    dfa = Automata::DFA.new(file: 'examples/dfa_sample.yml')
    
Presto! We have a fully functioning DFA machine.

#### Building with setters

You also have the option of setting each variable in the machine's _n_-tuple definition. For example, let's create a new empty DFA and define its states.

    dfa = Automata::DFA.new
    dfa.states = ['A', 'B', 'C', 'D']
    
We can define each property of the DFA in a similar manner.

### Playing with our machine

Now that we've built a machine, we can pass it input and let it work its magic. Consider our DFA built using our `examples/dfa_sample.yml` file, which accepts all strings starting with _00_. Let's experiment with some input:

    # We can make sure it's a valid DFA
    >> dfa.valid?
    => true
    >> dfa.accepts? '001'
    => true
    >> dfa.accepts? '0101'
    => false
    
Awesomesauce. Please refer to the [wiki](https://github.com/jico/automata/wiki "automata wiki") for more details.

## Special Characters

* _&_ - Represents an ε-transition (epsilon transition). 
* _@_ - Represents Δ (delta), or empty cell in stack/tape.

__Note:__ All special characters must be enclosed in quotations.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
