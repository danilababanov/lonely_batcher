require 'spec_helper'

describe LonelyBatcher::Processor do

  before do
    taxonomy = File.open('spec/fixtures/taxonomy.xml')
    destination = File.open('spec/fixtures/destinations.xml')
    @output_directory = "tmp"
    @batcher = LonelyBatcher::Processor.new(taxonomy, destination, @output_directory)
  end

  describe "#navigation" do
    it "should return html with div, nested uls and with an a tag inside an li tag" do
      expect(@batcher.navigation).to have_tag('div ul ul ul li a')
    end
  end

  describe "#perform" do
    it "should create files on disk" do
      @batcher.perform
      count = Dir[File.join(@output_directory, '**', '*')].count { |file| File.file?(file) }
      expect(count).to eq(25)
    end
  end
end

