require 'spec_helper'

describe Automata::Turing do
  
  ##
  # Turing from file
  #
  context "Initializing from a valid file" do
    before do
      @turing = Automata::Turing.new(file: 'examples/turing_1.yml')
    end
    
    it "should not accept '0'" do
      @turing.accepts?('0').should == false
    end
    
    it "should not accept '1'" do
      @turing.accepts?('1').should == false
    end
    
    it "should not accept the empty string" do
      @turing.accepts?('').should == false
    end
    
    it "should not accept '01'" do
      @turing.accepts?('01').should == false
    end
    
    it "should accept '101'" do
      @turing.accepts?('101').should == true
    end
    
    it "should accept '1010'" do
      @turing.accepts?('1010').should == true
    end
    
    it "should accept '01011'" do
      @turing.accepts?('01011').should == true
    end
  end
  
  context "Initializing an empty Turing" do
    before do
      @turing = Automata::Turing.new
    end
    
    it "should be created successfully" do
      @turing.should be_an_instance_of Automata::Turing
    end
  end
  
  ##
  # Turing params
  #
  context "Initializing a Turing by params" do
    before do
      states = ['A','B','C']
      inputAlphabet = [0,1]
      tapeAlphabet = [0,1]
      start = 'A'
      transitions = {
        'A' => {
          0 => {
            to: 'A',
            write: 0,
            move: 'R'
          },
          1 => {
            to: 'B',
            write: 1,
            move: 'R'
          }
        },
        'B' => {
          0 => {
            to: 'C',
            write: 0,
            move: 'R'
          },
          1 => {
            to: 'B',
            write: 1,
            move: 'R'
          }
        },
        'C' => {
          0 => {
            to: 'A',
            write: 0,
            move: 'R'
          },
          1 => {
            to: 'ACCEPT',
            write: 1,
            move: 'R'
          }
        }
      }
      params = {
        states: states,
        inputAlphabet: inputAlphabet,
        tapeAlphabet: tapeAlphabet,
        start: start,
        transitions: transitions
      }
      @turing = Automata::Turing.new(params)
    end
    
    it "should be created successfully" do
      @turing.should be_an_instance_of Automata::Turing
    end
    
    it "should not accept '0'" do
      @turing.accepts?('0').should == false
    end
    
    it "should not accept '1'" do
      @turing.accepts?('1').should == false
    end
    
    it "should not accept the empty string" do
      @turing.accepts?('').should == false
    end
    
    it "should not accept '01'" do
      @turing.accepts?('01').should == false
    end
    
    it "should accept '101'" do
      @turing.accepts?('101').should == true
    end
    
    it "should accept '1010'" do
      @turing.accepts?('1010').should == true
    end
    
    it "should accept '01011'" do
      @turing.accepts?('01011').should == true
    end
  end
end