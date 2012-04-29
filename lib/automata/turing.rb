module Automata
  # Turing Machine
  class Turing < StateDiagram
    attr_accessor :inputAlphabet, :tapeAlphabet, :tape, :reject

    # @todo Check that each state is connected.
    #   Iterate through each states to verify the graph
    #   is not disjoint.

    def initialize(params={})
      yaml = {}
      yaml = YAML::load_file(params[:file]) if params.has_key? :file
      super(params)
      @inputAlphabet = params[:inputAlphabet] || yaml['inputAlphabet']
      @tapeAlphabet = params[:tapeAlphabet] || yaml['tapeAlphabet']
      @tape = Tape.new
      @accept = false
      @reject = false
    end
    
    # Runs the input on the turing machine and returns a Hash describing
    # the machine's final state after running.
    #
    # @param [String] input the string to use as input/tape for the TM
    # @return [Hash] a hash describing the TM state after running
    #   * :input [String] the original input string
    #   * :accept [Boolean] whether or not the TM halted in an accept state
    #   * :reject [Boolean] whether or not the TM halted in a reject state
    #   * :head [String] the state which the head halted
    #   * :tape [String] the resulting tape string
    def feed(input) 
      @tape = Tape.new(input)
      @accept = false
      @reject = false

      stateHead = @start.to_s
      input.each_char do |symbol|
        toState = transition(stateHead, symbol)
        if @accept || @reject
          break
        else
          stateHead = toState
        end
      end
      
      resp = {
        input: input,
        accept: @accept,
        reject: @reject,
        head: stateHead,
        tape: @tape.memory,
        output: @tape.output
      }
      resp
    end

    # Determines whether the TM halts in an accept state.
    #
    # @param [String] input the string to use as input for the TM.
    # @return [Boolean] Whether or not the TM accepts the input string.
    def accepts?(input)
      resp = feed(input)
      resp[:accept]
    end
    
    # Determines whether the TM halts in an reject state.
    #
    # @param [String] input the string to use as input for the TM.
    # @return [Boolean] Whether or not the TM rejects the input string.
    def rejects?(input)
      resp = feed(input)
      resp[:reject]
    end

    # Determines the transition states, if any, from a given 
    # beginning state and input symbol pair.
    #
    # @note Turing machines have two unique states:
    #   * +ACCEPT+ Unique accept state 
    #   * +REJECT+ Unique reject state
    # @param [String] state state label for beginning state.
    # @param [String] symbol input symbol.
    # @return [Array] Array of destination transition states.
    def transition(state, symbol)
      actions = @transitions[state][symbol]
      @tape.transition(symbol, actions['write'], actions['move'])

      # Flip the bits for halting states
      @accept = true if actions['to'] == 'ACCEPT'
      @reject = true if actions['to'] == 'REJECT'
      @head = actions['to']
    end
    
    # Determines whether or not any transition states exist
    # given a beginning state and input symbol pair.
    #
    # @param (see #transition)
    # @return [Boolean] Whether or not a transition exists.
    def has_transition?(state, read)
      return false unless @transitions.include? state
      @transitions[state].has_key? read
    end
    
  end

  # Turing Machine tape
  class Tape
    attr_accessor :memory

    # Creates a new tape.
    # 
    # @param [String] string the input string
    def initialize(string=nil)
      if string
        @memory = []
        @memory << '@' unless string[0] == '@'
        @memory += string.split('')
        @memory << '@' unless string[-1] == '@'
        @head = 1
      end
    end

    # Transitions the tape.
    #
    # @param [String] read the input symbol read
    # @param [String] write the symbol to write
    # @param [String] move Either 'L', 'R', or 'S' (default) to 
    #   move left, right, or stay, respectively.
    # @return [Boolean] whether the transition succeeded
    def transition(read, write, move)
      if read == @memory[@head]
        @memory[@head] = write
        case move
        when 'R'
          # Move right
          @memory << '@' if @memory[@head + 1]
          @head += 1
        when 'L'
          # Move left
          @memory.unshift('@') if @head == 0
          @head -= 1
        end
        return true
      else
        return false
      end
    end

    # Trims the memory empty cells and outputs the tape string.
    #
    # @return [String] the tape memory string
    def output
      @memory.join.sub(/^@*/, '').sub(/@*$/, '')
    end

  end
end