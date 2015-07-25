require "lonely_batcher/version"
require "nokogiri"
require 'active_support'
require 'active_support/core_ext'
require 'rslt'
require 'lonely_batcher/navigation_builder'

module LonelyBatcher

  class Processor

    attr_reader :output_template, :taxonomy, :destination

    def initialize(taxonomy, destination)
      @output_template = File.open('lib/lonely_batcher/template/output.html').read
      @taxonomy = taxonomy.read
      @destination = destination.read
    end

    def output_file
      output = File.new("output.html", "w")
      output.write(@output_template)
      output.close
    end

    def navigation

    end
  end
end
