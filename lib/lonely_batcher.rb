require "lonely_batcher/version"


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
  end
end
