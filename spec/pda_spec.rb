require 'spec_helper'

describe Automata::PDA do
  
  ##
  # balanced bracket pda
  #
  context "Initializing from a valid file" do
    before do
      @pda = Automata::PDA.new(file: 'examples/pda_sample.yml')
    end
    
    it "should accept '()'" do
      @pda.accepts?('()').should == true
    end
    
    it "should accept '(())'" do
      @pda.accepts?('(())').should == true
    end
    
    it "should not accept the empty string" do
      @pda.accepts?('').should == false
    end
    
    it "should not accept '(('" do
      @pda.accepts?('((').should == false
    end
    
    it "should accept '(())'" do
      @pda.accepts?('(())').should == true
    end
    
    it "should accept '(()())'" do
      @pda.accepts?('(()())').should == true
    end
    
    it "should not accept '(()'" do
      @pda.accepts?('(()').should == false
    end
  end
  
  context "Initializing an empty pda" do
    before do
      @pda = Automata::PDA.new
    end
    
    it "should be created successfully" do
      @pda.should be_an_instance_of Automata::PDA
    end
  end
end
