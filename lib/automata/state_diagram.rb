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
      yaml = {}
      yaml = YAML::load_file(params[:file]) if params.has_key? :file
      @states = yaml['states'] || params[:states]
      @alphabet = yaml['alphabet'] || params[:alphabet]
      @start = yaml['start'] || params[:start]
      @accept = yaml['accept'] || params[:accept]
      @transitions = yaml['transitions'] || params[:transitions]
    end
    
  end
  
end