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
    #   - +string* -> The string to use as input for the DFA.
    #
    # * *Returns*:
    #   Whether or not the DFA accepts the string (boolean).
    #
    def accepts?(string)
      heads = [@start]
      string.each_char do |symbol|
        heads.each_with_index do |i, head|
          #--
          # Check if head can transition read symbol
          if @transitions[head].has_key? symbol
            heads[i] = @transitions[head][symbol]
          else
            #--
            # Head dies if no transition for symbol
            heads.delete_at i
          end
          #--
          # Check for empty-transition
          if @transitions[head].has_key? '&'
            heads << @transitions[head]['&']
          end
        end
        
        break if heads.empty?
      end
      is_accept_state? head
    end
    
    def is_accept_state?(state)
      @accept.include? state
    end
  end
  
end