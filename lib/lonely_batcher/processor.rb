module LonelyBatcher
  class Processor
    attr_reader :taxonomy, :destinations, :output_directory

    def initialize(taxonomy, destinations, output_directory)
      @taxonomy = Nokogiri::XML(taxonomy)
      @destinations = Nokogiri::XML(destinations)
      @output_directory = FileUtils::mkdir_p(output_directory).first
    end

    def navigation
      NavigationBuilder.transform(@taxonomy)
    end

    def perform
      copy_support_files()
      destination_elements = @destinations.xpath('/destinations/destination')
      destination_elements.each do |destination|
        begin
        destination_xml = Nokogiri::XML(destination.to_s)
        page = PageBuilder.new(destination_xml, navigation)
        atlas_id = page.atlas_id
        html = page.build
        write_file(html, atlas_id)
        rescue => e
          puts "there was an issue processing #{atlas_id}:"
          puts e.message
          puts e.backtrace
          puts "moving onto the next . . ."
          next
        end
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
