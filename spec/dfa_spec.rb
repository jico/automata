require 'spec_helper'

describe Automata::DFA do
  context "Initializing from a valid file" do
    before do
      @dfa = Automata::DFA.new
      @dfa.init_from_file('examples/dfa_sample.yml')
    end
    
    it "should be valid" do
      @dfa.is_valid?.should == true
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