require "lonely_batcher/version"
require "nokogiri"
require 'rslt'
require 'lonely_batcher/navigation_builder'
require 'fileutils'

module LonelyBatcher
  class Processor
    attr_reader :output_template, :taxonomy, :destinations, :navigation

    def initialize(taxonomy, destination, output_directory)
      @output_directory ||= FileUtils::mkdir_p(output_directory).first
      template = File.open('lib/lonely_batcher/template/output.html').read
      @output_template = Nokogiri::HTML(template)
      @support_files = FileUtils::cp_r 'lib/lonely_batcher/template/.', @output_directory
      @taxonomy = Nokogiri::XML(taxonomy.read)
      @destinations = Nokogiri::XML(destination.read)
      @navigation = NavigationBuilder.transform(@taxonomy)
      perform
    end

    def perform
      destination_elements = destinations.xpath('/destinations/destination')
      destination_elements.each do |destination|
        create_page(destination)
      end
    end

    def create_page(destination)
      atlas_id = destination.xpath('@atlas_id').text
      destination_name = destination.xpath('@title').text
      content = destination.xpath('introductory/introduction/overview[1]').text
      file = new_template(destination_name, content)
      write_file(file, atlas_id)
    end

    def new_template(destination_name, content)
      output = @output_template.to_s
      output.gsub!('{DESTINATION NAME}', destination_name)
      output.gsub!('CONTENT GOES HERE', content)
      output.gsub!('HIERARCHY NAVIGATION GOES HERE', navigation)
    end

    def write_file(file, atlas_id)
      puts atlas_id
      new_file = File.open( "#{@output_directory}/#{atlas_id}.html","w" )
      new_file << file
      new_file.close
    end
  end
end
