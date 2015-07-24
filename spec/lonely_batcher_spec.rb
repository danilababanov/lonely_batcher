require 'spec_helper'

describe LonelyBatcher do

  it "prints" do
    taxonomy = File.open('spec/fixtures/taxonomy.xml')
    destination = File.open('spec/fixtures/destinations.xml')
    file = LonelyBatcher::Processor.new(taxonomy, destination)
    file.output_file
  end
end

