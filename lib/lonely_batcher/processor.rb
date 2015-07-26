module LonelyBatcher
  class Processor
    attr_reader :taxonomy, :destinations, :output_directory

    def initialize(taxonomy, destination, output_directory)
      @output_directory = FileUtils::mkdir_p(output_directory).first
      @taxonomy = Nokogiri::XML(taxonomy.read)
      @destinations = Nokogiri::XML(destination.read)
    end

    def navigation
      NavigationBuilder.transform(@taxonomy)
    end

    def perform
      copy_support_files()
      destination_elements = destinations.xpath('/destinations/destination')
      destination_elements.each do |destination|
        destination_xml = Nokogiri::XML(destination.to_s)
        page = PageBuilder.new(destination_xml, navigation)
        atlas_id = page.atlas_id
        html = page.build
        write_file(html, atlas_id)
      end
    end

    private

    def write_file(html, atlas_id)
      new_file = File.open( "#{@output_directory}/#{atlas_id}.html","w" )
      new_file << html
      new_file.close
    end

    def copy_support_files
      FileUtils::cp_r 'lib/lonely_batcher/template/.', @output_directory
      FileUtils.rm @output_directory + "/output.html"
    end
  end
end
