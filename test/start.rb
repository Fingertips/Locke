require 'rubygems'
require 'bacon'
require 'mocha'

require 'fileutils'

$:.unshift File.expand_path('../../lib', __FILE__)

require 'locke'

Bacon.extend Bacon::KnockOutput

module Test
  def self.root
    File.expand_path('../', __FILE__)
  end
end