module Automata
  # Push Down Automata
  class PDA < NFA
    attr_accessor :stack

    # Initialize a PDA object.  See state_diagram.rb for paramters.
    #
    # TODO: do i need to define params here they are the same?
    # 
    def initialize(params={})
      super(params)
      @stack = []
    end

    # Determines whether the PDA accepts a given string.
    #
    # This method is intended to override the parent accepts method.
    #
    # @param [String] input the string to use as input for PDA.
    # @return [Boolean] whether or not hte PDA accepts the string.
    def accepts?(input)
      resp = feed(input)
      resp[:accept]
    end

    def has_transition?(state, symbol)
      #TODO
    end

    def transition(state, symbol)
      # TODO
    end
  end
end
