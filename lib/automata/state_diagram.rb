module Automata
  # A generic state diagram class represented as a 5-tuple.
  class StateDiagram
    attr_accessor :states, :alphabet, :start, :accept, :transitions
    
    # @todo Validate machine
    #   Check that each transition reads a valid, declared
    #   input symbol.
    
    # @return [Boolean] whether or not each transition has valid input symbols
    def check_input_integrity
      transition_chars = []
      @transitions.fetch_values.each {|t| transition_chars << t.fetch_keys}
      transition_chars = transition_chars.flatten.map!{|c| c.to_s}
      return  - @alphabet == []
    end
    
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
      
      return unless check_input_integrity
    end
    
    #Depth first search, check if every state can be reached by a combination of states > trans ..
    # @return [Boolean] whether or not each state is connected
    def all_connected?
      return dfs_search(@states, @start)
    end

    # @param [Array<String>] the state labels of the machine.
    # @param [String] start state label for beginning state.
    def dfs_search(states, start)
      color = Hash.new(:WHITE)
      que =[]
      color[@transitions[start]] = :GREY #color contains Hashes [Trans => State]
      que.push(start)
      while !que.empty? do
        cur_state = que.pop

        @transitions[cur_state].each do |next_state|
          if color[state] == :WHITE #not yet visited
            color[state] = :GREY
            que.push next_state
          end
        end

        color[cur_state] = :BLACK
      end

      return color.fetch_values.detect{|c| c != :BLACK} == nil
    end
  end
end
