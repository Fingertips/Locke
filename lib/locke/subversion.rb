require 'executioner'

module Locke
  class Subversion
    class Repository
      include Executioner
      executable :svn
      
      def initialize(path)
        @path = path
      end
      
      def last_revision
        attributes['Revision'].to_i
      end
      
      def attributes
        self.class.parse_attributes(svn("info #{@path}"))
      end
      
      def self.parse_attributes(input)
        input.split("\n").inject({}) do |attributes, line|
          key, value = line.split(':')
          attributes[key.strip] = value.strip
          attributes
        end
      end
    end
  end
end