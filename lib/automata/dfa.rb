module Automata
  # Deterministic Finite Automata.
  class DFA < StateDiagram
    # Verifies that the initialized DFA is valid.
    # Checks that each state has a transition for each
    # symbol in the alphabet.
    #
    # @return [Boolean] whether or not the DFA is valid.
    def valid?
      # @todo #DONE# Check that each state is connected.
      #   Iterate through each states to verify the graph
      #   is not disjoint.
      return false unless all_connected?
      
      @transitions.each do |key, val|
        @alphabet.each do |a| 
          return false unless @transitions[key].has_key? a.to_s
        end
      end
      return true
    end
    
    # Runs the input on the machine and returns a Hash describing
    # the machine's final state after running.
    #
    # @param [String] input the string to use as input for the DFA
    # @return [Hash] a hash describing the DFA state after running
    #   * :input [String] the original input string
    #   * :accept [Boolean] whether or not the DFA accepted the string
    #   * :head [String] the state which the head is currently on
    def feed(input)
      head = @start.to_s
      input.each_char { |symbol| head = @transitions[head][symbol] }
      accept = is_accept_state? head
      resp = {
        input: input,
        accept: accept,
        head: head 
      }
      resp
    end

    # Determines whether the DFA accepts a given string.
    #
    # @param [String] input the string to use as input for the DFA.
    # @return [Boolean] whether or not the DFA accepts the string.
    def accepts?(input)
      resp = feed(input)
      resp[:accept]
    end
    
    # Determines if a given state is an accept state.
    #
    # @param [String] state the state label to check.
    # @return [Boolean] whether or not the state is an accept state.
    def is_accept_state?(state)
      @accept.include? state.to_s
    end
  end
end
