module Automata
  # Push Down Automata
  class PDA < NFA
    attr_accessor :stack

    # Initialize a PDA object.
    def initialize(params={})
      super(params)
      @alphabet << '&' unless !@alphabet || @alphabet.include?('&')
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
      heads, @stack, accept = [@start], [], false
      
      # Move any initial e-transitions
      eTrans = transition(@start, '&') if has_transition?(@start, '&')
      heads += eTrans

      puts "initial heads: #{heads}"
      puts "initial stack: #{@stack}"

      # Iterate through each symbol of input string
      input.each_char do |symbol|
        newHeads = []
        
        puts "Reading symbol: #{symbol}"

        heads.each do |head|
          puts "At head #{head}"

          # Check if head can transition read symbol
          # Head dies if no transition for symbol
          if has_transition?(head, symbol)
            puts "Head #{head} transitions #{symbol}"
            puts "stack: #{@stack}"
            transition(head, symbol).each { |t| newHeads << t }
            puts "heads: #{newHeads}"
            puts "stack: #{@stack}"
          end

        end
        
        heads = newHeads
        break if heads.empty?
      end

      puts "Loop finished"
      
      accept = includes_accept_state? heads

      puts "heads: #{heads}"
      puts "stack: #{stack}"
      puts "accept: #{accept}"

      resp = {
        input: input,
        accept: accept,
        heads: heads,
        stack: stack
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

    # Determines the transition states, if any, from a given 
    # beginning state and input symbol pair.
    #
    # @param [String] state state label for beginning state.
    # @param [String] symbol input symbol.
    # @return [Array] Array of destination transition states.
    def transition(state, symbol, stackTop=nil)
      dests = []

      if has_transition?(state, symbol)
        actions = @transitions[state][symbol]
        stackTop ||= @stack.last
        able = true
        @stack.push actions['push'] if actions['push']
        if actions['pop']
          able = false unless stackTop == actions['pop']
          @stack.pop if able
        end
        if able
          dests << actions['to']

          if has_transition?(actions['to'], '&')
            actions = @transitions[actions['to']]['&']
            able = true
            @stack.push actions['push'] if actions['push']
            if actions['pop']
              able = false unless @stack.last == actions['pop']
              @stack.pop if able
            end
            if able
              dests << actions['to']
            end
          end
          dests
        else
          return dests
        end
      else
        return []
      end
    end

    def pop?(symbol)
      @stack.last == symbol
    end

    # Determines whether or not any transition states exist
    # given a beginning state and input symbol pair.
    #
    # @param (see #transition)
    # @return [Boolean] Whether or not a transition exists.
    def has_transition?(state, symbol)
      return false unless @transitions.has_key? state
      if @transitions[state].has_key? symbol
        actions = @transitions[state][symbol]
        return false if actions['pop'] && @stack.last != actions['pop']
        return true
      else
        return false
      end
    end

    # Determines if a given state is an accept state.
    #
    # @param [String] state the state label to check.
    # @return [Boolean] whether or not the state is an accept state.
    def accept_state?(state)
      @accept.include? state
    end

    def includes_accept_state?(states)
      states.each { |s| return true if accept_state? s }
      return false
    end
  end
end
