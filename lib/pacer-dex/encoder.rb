require 'java'
require 'yaml'

module Pacer::Dex
  # This encoder was originally part of pacer-neo4j. It uses native data where
  # Neo4j could and for everything else it uses (slow (but easy))
  # human-readable YAML encoding.
  class Encoder
    def self.encode_property(value)
      case value
      when nil
        nil
      when String
        value = value.strip
        value = nil if value == ''
        value
      when Fixnum
        value.to_java :int rescue dump value
      when Float
        value.to_java :double
      when Bignum
        dump value
      when true, false
        value.to_java :boolean
      else
        dump value
      end
    end

    def self.decode_property(value)
      if value.is_a? String and value[0, 1] == ' '
        YAML.load(value[1...-1])
      else
        value
      end
    end

    private

    def self.dump(value)
      # Leading space signifies a binary. It would otherwise be stripped.
      " #{ YAML.dump value }"
    end
  end
end
