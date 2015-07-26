module LonelyBatcher
  class PageBuilder
    attr_reader :destination_name, :content, :navigation

    def initialize(destination, navigation)
      @navigation = navigation
      @destination_name = destination.xpath('destination/@title').text
      @atlas_id = destination.xpath('destination/@atlas_id').text
      @content = destination.xpath('destination/introductory/introduction').text
    end

    def template
      file = File.open('lib/lonely_batcher/template/output.html').read
      Nokogiri::HTML(file)
    end

    def build
      output = template.to_s
      output.gsub!('{DESTINATION NAME}', destination_name) 
      output.gsub!('CONTENT GOES HERE', content)
      output.gsub!('HIERARCHY NAVIGATION GOES HERE', navigation)
      output
    end
  end
end
