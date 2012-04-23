# -*- encoding: utf-8 -*-
require File.expand_path('../lib/automata/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jico Baligod"]
  gem.email         = ["jico@baligod.com"]
  gem.description   = %q{Create and simulate automaton.}
  gem.summary       = %q{This gem provides a number of classes to create and simulate Deterministic/Nondeterministic Finite Automata, Push-down Automata, and Turing Machines.}
  gem.homepage      = "http://github.com/jico/automata"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "automata"
  gem.require_paths = ["lib"]
  gem.version       = Automata::VERSION
  
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~>2.9.0"
end
