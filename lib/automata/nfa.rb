module Automata
  
  ##
  # Deterministic Finite Automata.
  # 
  # NFA nodes do not need to have a transition for each
  # symbol in the alphabet. Empty transitions, denoted by 
  # the '&' charactar, force a transition to another node.
  #
  #--
  # TODO: Check that each state is connected.
  #
  class NFA < StateDiagram
    
    #--
    # TODO: Check if valid NFA.
    #
    
    ##
    # Determines whether the NFA accepts the given string.
    #
    # * *Args*:
    #   - +string+ -> The string to use as input for the DFA.
    # * *Returns*:
    #   Whether or not the DFA accepts the string (boolean).
    #
    def accepts?(string)
      heads = [@start]
      string.each_char do |symbol|
        newHeads = []
        heads.each_with_index do |head, i|
          #--
          # Check if head can transition read symbol
          # Head dies if no transition for symbol
          if has_transition?(head, symbol)
            transition(head, symbol).each { |t| newHeads << t }
          end
        end
        heads = newHeads
        break if heads.empty?
      end
      
      heads.each { |head| return true if accept_state? head }
      false
    end
    
    ##
    # Determine the states to transition to from a given
    # state and input symbol.
    #
    # * *Args*:
    #   - +state+ -> State transitioning from.
    #   - +input+ -> Input symbol.
    # * *Returns*:
    #   The array of transition states. Nil if none.
    #
    def transition(state, input)
      if has_transition?(state, input)
        dests = @transitions[state][input]
        dests = [dests] unless dests.kind_of? Array
        dests
      else
        nil
      end
    end
    
    ##
    # Determine whether or not a transition exists
    # for a state, given an input symbol.
    #
    # * *Args*:
    #   - +state+ -> State transitioning from.
    #   - +input+ -> Input symbol.
    # * *Returns*:
    #   Whether a transition exists. (boolean)
    #
    def has_transition?(state, input)
      return false unless @transitions.include? state
      @transitions[state].has_key? input
    end
    
    ##
    # Determine if a given state is an accept state.
    #
    # * *Args*:
    #   - +state+ -> The state.
    # * *Returns*:
    #   Whether or not the state is an accept state. (boolean)
    #
    def accept_state?(state)
      @accept.include? state
    end
  end
  
end