require 'spec_helper'

describe LonelyBatcher do
  describe LonelyBatcher::Processor do

    before do
      taxonomy = File.open('spec/fixtures/taxonomy.xml')
      destination = File.open('spec/fixtures/destinations.xml')
      @batcher = LonelyBatcher::Processor.new(taxonomy, destination)
    end

    describe '#urls' do
      it "should get a valid url for each destination" do
        # TODO: make this less brittle
        expect(@batcher.atlas_ids).to include('355064')
      end
    end

    describe "#navigation" do
      it "should return html" do
        expect(@batcher).to respond_to(:navigation)
      end
    end
  end
end
