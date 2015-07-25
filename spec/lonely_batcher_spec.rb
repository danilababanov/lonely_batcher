require 'spec_helper'

describe LonelyBatcher do
  describe LonelyBatcher::Processor do

    before do
      taxonomy = File.open('spec/fixtures/taxonomy.xml')
      destination = File.open('spec/fixtures/destinations.xml')
      output_directory = "spec/fixtures/temp"
      @batcher = LonelyBatcher::Processor.new(taxonomy, destination, output_directory)
    end

    describe "#navigation" do
      it "should return html" do
        expect(@batcher.navigation).to include('<ul>')
      end
    end
  end
end
