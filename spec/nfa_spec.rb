require 'spec_helper'

describe Automata::NFA do
  
  context "Initializing from a valid file" do
    before do
      @nfa = Automata::NFA.new(file: 'examples/nfa_sample.yml')
    end
    
    it "should accept 'a'" do
      @nfa.accepts?('a').should == true
    end
    
    it "should accept 'aa'" do
      @nfa.accepts?('aa').should == true
    end
    
    it "should accept the empty string" do
      @nfa.accepts?('').should == true
    end
    
    it "should not accept 'b'" do
      @nfa.accepts?('b').should == false
    end
    
    it "should accept 'ab'" do
      @nfa.accepts?('ab').should == true
    end
    
    it "should accept 'abab'" do
      @nfa.accepts?('abab').should == true
    end
    
    it "should accept 'aab'" do
      @nfa.accepts?('aab').should == false
    end
  end
  
  context "Initializing an empty NFA" do
    before do
      @nfa = Automata::NFA.new
    end
    
    it "should be created successfully" do
      @nfa.should be_an_instance_of Automata::NFA
    end
  end
  
  context "Initializing a NFA by params" do
    before do
      states = ['q1','q2','q3','q4']
      alphabet = ['a','b']
      start = 'q1'
      accept = ['q1','q2','q4']
      transitions = {
        'q1' => {
          'a' => ['q2','q3']
        },
        'q2' => {
          'a' => 'q2'
        },
        'q3' => {
          'b' => 'q4'
        },
        'q4' => {
          'a' => 'q3'
        }
      }
      params = {
        states: states,
        alphabet: alphabet,
        start: start,
        accept: accept,
        transitions: transitions
      }
      @nfa = Automata::NFA.new(params)
    end
    
    it "should be created successfully" do
      @nfa.should be_an_instance_of Automata::NFA
    end
    
    it "should accept 'a'" do
      @nfa.accepts?('a').should == true
    end
    
    it "should accept 'aa'" do
      @nfa.accepts?('aa').should == true
    end
    
    it "should accept the empty string" do
      @nfa.accepts?('').should == true
    end
    
    it "should not accept 'b'" do
      @nfa.accepts?('b').should == false
    end
    
    it "should accept 'ab'" do
      @nfa.accepts?('ab').should == true
    end
    
    it "should accept 'abab'" do
      @nfa.accepts?('abab').should == true
    end
    
    it "should accept 'aab'" do
      @nfa.accepts?('aab').should == false
    end
  end
end