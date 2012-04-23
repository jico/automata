module Automata
  
  ##
  # A generic state diagram class represented as a 5-tuple.
  #
  #--
  # TODO: Check for valid transitions against declared states and alphabet.
  #
  class StateDiagram
    attr_accessor :states, :alphabet, :start, :accept, :transitions
    
    def initialize(params={})
      @states = params[:states]
      @alphabet = params[:alphabet]
      @start = params[:start]
      @accept = params[:accept]
      @transitions = params[:transitions]
    end
    
    def init_from_file(filename)
      yaml = YAML::load_file(filename)
      @states = yaml['states']
      @alphabet = yaml['alphabet']
      @start = yaml['start']
      @accept = yaml['accept']
      @transitions = yaml['transitions']
      yaml
    end
    
  end
  
end