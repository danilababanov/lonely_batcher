require "lonely_batcher/version"
require "nokogiri"
require 'active_support'
require 'active_support/core_ext'
require 'rslt'
require 'lonely_batcher/navigation_builder'

module LonelyBatcher

  class Processor

    attr_reader :output_template, :taxonomy, :destination

    def initialize(taxonomy, destination, output_directory)
      @output_template = File.open('lib/lonely_batcher/template/output.html').read
      @taxonomy = Nokogiri::XML(taxonomy.read)
      @destinations = Nokogiri::XML(destination.read)
      @output_directory = output_directory
    end

    def output_file
      output = File.new("output.html", "w")
      output.write(@output_template)
      output.close
    end

    def atlas_ids
      destination_elements = @destinations.xpath('destinations/destination')
      atlas_ids = destination_elements.collect { |element| element.xpath('@atlas_id').to_s.to_i }
      atlas_ids
    end

    def destination_url(atlas_id)
      xpath_query = "//node[@atlas_node_id='#{atlas_id}'][1]/node_name"
      end_node = @taxonomy.xpath(xpath_query).first
      node_names = end_node.ancestors.collect { |ancestor| ancestor.xpath('node_name').text }
      node_names = node_names.collect { |name| name.downcase.gsub(' ', '_') }
      node_names.reject! { |string| string.empty? }
      node_names.reverse!
      node_names.join('/')
    end

    def navigation

    end
  end
end
