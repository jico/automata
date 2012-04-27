module Automata
  # A generic state diagram class represented as a 5-tuple.
  class StateDiagram
    attr_accessor :states, :alphabet, :start, :accept, :transitions
    
    # @todo Validate machine
    #   Check that each transition reads a valid, declared
    #   input symbol.
    
    # Initialize and build a StateDiagram object.
    #
    # @param [Hash] params the parameters to build the machine with.
    # @option [String] :file a YAML file containing machine params.
    # @option [Array<String>] :states the state labels of the machine.
    # @option [Array<String>] :alphabet the alphabet of input symbols.
    # @option [String] :start the start state of the machine.
    # @option [Array<String>] :accept the accept states of the machine.
    # @option [Hash] :transitions nested hash of transitions for each state.
    # @note The :transitions hash structure will vary
    #   Different machines will require different transition structures.
    #   Please refer to the {http://github.com/jico/automata/wiki wiki}
    #   for details regarding each machine type.
    def initialize(params={})
      yaml = {}
      yaml = YAML::load_file(params[:file]) if params.has_key? :file
      @states = yaml['states'] || params[:states]
      @alphabet = yaml['alphabet'] || params[:alphabet]
      @start = yaml['start'] || params[:start]
      @accept = yaml['accept'] || params[:accept]
      @transitions = yaml['transitions'] || params[:transitions]
      @transitions = Hash.keys_to_strings(@transitions)
    end
  end
end