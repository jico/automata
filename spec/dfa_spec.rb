require 'spec_helper'

describe Automata::DFA do
  
  context "Initializing from a valid file" do
    before do
      @dfa = Automata::DFA.new(file: 'examples/dfa_sample.yml')
    end
    
    it "should be valid" do
      @dfa.should be_valid
    end
    
    it "should accept '00'" do
      @dfa.accepts?('00').should == true
    end
    
    it "should accept '001101'" do
      @dfa.accepts?('001101').should == true
    end
    
    it "should not accept the empty string" do
      @dfa.accepts?('').should == false
    end
    
    it "should not accept '0'" do
      @dfa.accepts?('0').should == false
    end
    
    it "should not accept '1'" do
      @dfa.accepts?('1').should == false
    end
    
    it "should not accept '01'" do
      @dfa.accepts?('01').should == false
    end
    
    it "should not accept '100'" do
      @dfa.accepts?('100').should == false
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
      states = %w( A B C D )
      alphabet = %w( 0 1 )
      start = 'A'
      accept = %w( C )
      transitions = {
        'A' => {
          '0' => 'B',
          '1' => 'D'
        },
        'B' => {
          '0' => 'C',
          '1' => 'D'
        },
        'C' => {
          '0' => 'C',
          '1' => 'C'
        },
        'D' => {
          '0' => 'D',
          '1' => 'D'
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
    
    it "should accept '00'" do
      @dfa.accepts?('00').should == true
    end
    
    it "should accept '001101'" do
      @dfa.accepts?('001101').should == true
    end
    
    it "should not accept the empty string" do
      @dfa.accepts?('').should == false
    end
    
    it "should not accept '0'" do
      @dfa.accepts?('0').should == false
    end
    
    it "should not accept '1'" do
      @dfa.accepts?('1').should == false
    end
    
    it "should not accept '01'" do
      @dfa.accepts?('01').should == false
    end
    
    it "should not accept '100'" do
      @dfa.accepts?('100').should == false
    end
  end
end