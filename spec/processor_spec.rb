require 'spec_helper'

describe LonelyBatcher::Processor do

  before do
    taxonomy = File.open('spec/fixtures/taxonomy.xml')
    destination = File.open('spec/fixtures/destinations.xml')
    output_directory = "spec/fixtures/temp"
    @batcher = LonelyBatcher::Processor.new(taxonomy, destination, output_directory)
  end

  describe "#navigation" do
    it "should return html with div, nested uls and with an a tag inside an li tag" do
      expect(@batcher.navigation).to have_tag('div ul ul ul li a')
    end
  end
end

