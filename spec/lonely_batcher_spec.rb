require 'spec_helper'

describe LonelyBatcher do
  describe LonelyBatcher::Processor do

    before do
      taxonomy = File.open('spec/fixtures/taxonomy.xml')
      destination = File.open('spec/fixtures/destinations.xml')
      output_directory = "/xyz"
      @batcher = LonelyBatcher::Processor.new(taxonomy, destination, output_directory)
    end

    describe '#atlas_ids' do
      it "collects all atlas_ids from the destinations file and returns ids in array" do
        # TODO: make this less brittle
        expect(@batcher.atlas_ids).to all(be_an(Integer))
      end
    end

    describe "#destination_url(atlas_id)", focus: true do
      it "should return a URL for a given id based on its location in the taxonomy tree" do
        id = @batcher.atlas_ids.last
        expect(@batcher.destination_url(id)).not_to be_nil
      end
    end

    describe "#navigation" do
      it "should return html" do
        expect(@batcher).to respond_to(:navigation)
      end
    end
  end
end
