require 'executioner'

module Locke
  class Subversion
    class Repository
      include Executioner
      executable :svn
      
      def initialize(path)
        @path = path
      end
      
      def changes
        if last_revision > 1
          (2..last_revision).map do |revision|
            self.class.count_changes(svn("diff -x -b --change #{revision} #{@path}"))
          end
        else
          []
        end
      end
      
      def last_revision
        attributes['Revision'].to_i
      end
      
      def attributes
        @attributes ||= self.class.parse_attributes(svn("info #{@path}"))
      end
      
      def self.parse_attributes(input)
        input.split("\n").inject({}) do |attributes, line|
          key, value = line.split(':')
          attributes[key.strip] = value.strip
          attributes
        end
      end
      
      def self.count_changes(input)
        input.split("\n").inject({:added => 0, :removed => 0}) do |changes, line|
          if %w(--- +++).include?(line[0,3])
            changes
          else
            case line[0,1]
            when '+'
              changes[:added] += 1
            when '-'
              changes[:removed] += 1
            end
            changes
          end
        end
      end
    end
  end
end