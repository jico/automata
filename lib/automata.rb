require "automata/version"
require 'yaml'
require "automata/state_diagram"
require "automata/dfa"
require "automata/nfa"
require "automata/pda"
require "automata/turing"

module Automata

end

class Hash
  # Transforms all keys of a hash to strings.
  #
  # @param [Hash] the Hash whose keys to convert.
  # @return [Hash] the new Hash with strings as keys.
  def self.keys_to_strings(obj)
    return obj unless obj.kind_of? Hash
    obj = obj.inject({}){|h,(k,v)| h[k.to_s] = Hash.keys_to_strings(v); h}
    return obj
  end
end
