module Automata
  
  ##
  # Deterministic Finite Automata.
  # 
  # Each state of a DFA must have exactly one transition for each transition
  # defined at creation.
  #
  #--
  # TODO: Check that each state is connected.
  #
  class DFA < StateDiagram
    
    ##
    # Verify that the initialized DFA is valid.
    #
    # * *Returns*:
    #   Whether or not the DFA is valid (boolean).
    #
    def valid?
      @transitions.each do |key, val|
        @alphabet.each { |a| return false unless @transitions[key].has_key? a }
      end
      true
    end
    
    ##
    # Determines whether the DFA accepts the given string.
    #
    # * *Args*:
    #   - +string+ -> The string to use as input for the DFA.
    #
    # * *Returns*:
    #   Whether or not the DFA accepts the string (boolean).
    #
    def accepts?(string)
      head = @start
      string.each_char do |symbol|
        head = @transitions[head][symbol]
      end
      is_accept_state? head
    end
    
    def is_accept_state?(state)
      @accept.include? state
    end
  end
  
end