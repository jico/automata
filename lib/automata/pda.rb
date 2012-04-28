module Automata
  # Push Down Automata
  class PDA < DFA
    # Determines whether the PDA accepts a given string.
    #
    # This method is intended to override the parent accepts method.
    #
    # @param [String] input the string to use as input for PDA.
    # @return [Boolean] whether or not hte PDA accepts the string.
    def accepts?(input)
      # TODO
      return true
    end
  end
end
