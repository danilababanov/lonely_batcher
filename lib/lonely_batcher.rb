require 'nokogiri'
require 'rslt'
require 'fileutils'

require 'lonely_batcher/version'
require 'lonely_batcher/navigation_builder'
require 'lonely_batcher/page_builder'

module LonelyBatcher
  class Processor
    attr_reader :taxonomy, :destinations

    def initialize(taxonomy, destination, output_directory)
      @output_directory = FileUtils::mkdir_p(output_directory).first
      @taxonomy = Nokogiri::XML(taxonomy.read)
      @destinations = Nokogiri::XML(destination.read)
      perform()
    end

    def navigation
      NavigationBuilder.transform(@taxonomy)
    end

    def perform
      copy_support_files()
      destination_elements = destinations.xpath('/destinations/destination')
      destination_elements.each do |destination|
        new_page = PageBuilder.new(destination, navigation, output_directory)
        write_file(new_page)
      end
    end

    private

    def write_file(file)
      new_file = File.open( "#{@output_directory}/#{file.atlas_id}.html","w" )
      new_file << file
      new_file.close
    end

    def copy_support_files
      FileUtils::cp_r 'lib/lonely_batcher/template/.', @output_directory
    end
  end
end
