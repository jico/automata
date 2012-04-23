require 'spec_helper'

describe Automata::DFA do
  
  context "Initializing from a valid file" do
    before do
      @dfa = Automata::DFA.new(file: 'examples/dfa_sample.yml')
    end
    
    it "should be valid" do
      @dfa.should be_valid
    end
    
    it "should accept '01'" do
      @dfa.accepts?('01').should == true
    end
    
    it "should accept '001101'" do
      @dfa.accepts?('001101').should == true
    end
    
    it "should not accept the empty string" do
      @dfa.accepts?('').should == false
    end
    
    it "should not accept '10'" do
      @dfa.accepts?('10').should == false
    end
  end
  
  context "Initializing an empty DFA" do
    before do
      @dfa = Automata::DFA.new
    end
    
    it "should be created successfully" do
      @dfa.should be_an_instance_of Automata::DFA
    end
  end
  
  context "Initializing a DFA by params" do
    before do
      states = ['q1','q2','q3']
      alphabet = ['0','1']
      start = 'q1'
      accept = ['q3']
      transitions = {
        'q1' => {
          '0' => 'q2',
          '1' => 'q2'
        },
        'q2' => {
          '0' => 'q1',
          '1' => 'q3'
        },
        'q3' => {
          '0' => 'q3',
          '1' => 'q3'
        }
      }
      params = {
        states: states,
        alphabet: alphabet,
        start: start,
        accept: accept,
        transitions: transitions
      }
      @dfa = Automata::DFA.new(params)
    end
    
    it "should create a valid DFA" do
      @dfa.should be_valid
    end
    
    it "should accept '01'" do
      @dfa.accepts?('01').should == true
    end
    
    it "should accept '001101'" do
      @dfa.accepts?('001101').should == true
    end
    
    it "should not accept the empty string" do
      @dfa.accepts?('').should == false
    end
    
    it "should not accept '10'" do
      @dfa.accepts?('10').should == false
    end
  end
end