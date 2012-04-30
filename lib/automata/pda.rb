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

    # Runs the input on the machine and returns a Hash describing
    # the machine's final state after running.
    #
    # @param [String] input the string to use as input for the PDA
    # @return [Hash] a hash describing the PDA state after running
    #   * :input [String] the original input string
    #   * :accept [Boolean] whether or not the PDA accepted the string
    #   * :heads [Array] the state which the head is currently on
    def feed(input)
      head = @start

      # Iterate through each symbol of input string
      input.each_char do |symbol|
        if has_transition?(head, symbol)
          head = transition(head, symbol)
        end
      end
    
      accept = false
      if accept_state? head
        accept = true
      end

      resp = {
        input: input,
        accept: accept,
        head: head,
        stack: @stack
      }
    end


    # Determines whether the PDA accepts a given string.
    #
    # This method is intended to override the parent accepts method.
    #
    # @param [String] input the string to use as input for PDA.
    # @return [Boolean] whether or not the PDA accepts the string.
    def accepts?(input)
      resp = feed(input)
      resp[:accept]
    end

    # Determines the transition state, if any, from a given 
    # beginning state and input symbol pair.
    #
    # @param [String] state state label for beginning state.
    # @param [String] symbol input symbol.
    # @return [String] state destination state.
    def transition(state, symbol)
      dest, action = @transitions[state][symbol]
    end
  end
end
