module Automata
  # Deterministic Finite Automata.
  class DFA < StateDiagram
    # Verifies that the initialized DFA is valid.
    # Checks that each state has a transition for each
    # symbol in the alphabet.
    #
    # @return [Boolean] whether or not the DFA is valid.
    def valid?
      # @todo Check that each state is connected.
      #   Iterate through each states to verify the graph
      #   is not disjoint.
      @transitions.each do |key, val|
        @alphabet.each { |a| return false unless @transitions[key].has_key? a }
      end
      true
    end
    
    # Determines whether the DFA accepts a given string.
    #
    # @param [String] input the string to use as input for the DFA.
    # @return [Boolean] whether or not the DFA accepts the string.
    def accepts?(input)
      head = @start
      input.each_char do |symbol|
        head = @transitions[head][symbol]
      end
      is_accept_state? head
    end
    
    # Determines if a given state is an accept state.
    #
    # @param [String] state the state label to check.
    # @return [Boolean] whether or not the state is an accept state.
    def is_accept_state?(state)
      @accept.include? state
    end
  end
end