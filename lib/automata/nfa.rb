module Automata
  # Nondeterministic Finite Automata.
  class NFA < StateDiagram
    # @todo Check that each state is connected.
    #   Iterate through each states to verify the graph
    #   is not disjoint.
    
    # Runs the input on the machine and returns a Hash describing
    # the machine's final state after running.
    #
    # @param [String] input the string to use as input for the NFA
    # @return [Hash] a hash describing the NFA state after running
    #   * :input [String] the original input string
    #   * :accept [Boolean] whether or not the NFA accepted the string
    #   * :heads [Array] the state which the head is currently on
    def feed(input)
      heads = [@start]
      
      # Move any initial e-transitions
      if has_transition?(@start, '&')
        transition(@start, '&').each { |h| heads << h } 
      end
      
      # Iterate through each symbol of input string
      input.each_char do |symbol|
        newHeads, eTrans = [], []
                
        heads.each do |head|
          # Check if head can transition read symbol
          # Head dies if no transition for symbol
          if has_transition?(head, symbol)
            transition(head, symbol).each { |t| newHeads << t }
          end
        end
        
        # Move any e-transitions
        newHeads.each do |head|
          if has_transition?(head, '&')
            transition(head, '&').each { |t| eTrans << t }
          end
        end
        eTrans.each { |t| newHeads << t }
        
        heads = newHeads
        break if heads.empty?
      end
      
      accept = false
      heads.each { |head| accept = true if accept_state? head }

      resp = {
        input: input,
        accept: accept,
        heads: heads
      }
    end

    # Determines whether the NFA accepts a given string.
    #
    # @param [String] input the string to use as input for the NFA.
    # @return [Boolean] Whether or not the NFA accepts the input string.
    def accepts?(input)
      resp = feed(input)
      resp[:accept]
    end
    
    # Determines the transition states, if any, from a given 
    # beginning state and input symbol pair.
    #
    # @note NFA ε-transitions
    #   ε-transitions are supported through the use of the
    #   reserved input alphabet character '&'.
    # @param [String] state state label for beginning state.
    # @param [String] symbol input symbol.
    # @return [Array] Array of destination transition states.
    def transition(state, symbol)
      dests = @transitions[state][symbol]
      dests = [dests] unless dests.kind_of? Array
      dests
    end
    
    # Determines whether or not any transition states exist
    # given a beginning state and input symbol pair.
    #
    # @param (see #transition)
    # @return [Boolean] Whether or not a transition exists.
    def has_transition?(state, symbol)
      return false unless @transitions.include? state
      @transitions[state].has_key? symbol
    end
    
    # Determines if a given state is an accept state.
    #
    # @param [String] state the state label to check.
    # @return [Boolean] whether or not the state is an accept state.
    def accept_state?(state)
      @accept.include? state
    end
  end
end