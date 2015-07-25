require 'spec_helper'

describe LonelyBatcher::NavigationBuilder do

  describe ".transform" do
    it "taxonomy_name should be in h3 tags" do

      xml = <<-XML
      <taxonomies>
        <taxonomy>
          <taxonomy_name>Here</taxonomy_name>
        </taxonomy>
      </taxonomies>
      XML

      expect(LonelyBatcher::NavigationBuilder.transform(xml)).to include('<h3>Here</h3>')
    end

    it "spits out a file" do
      xml = File.open('spec/fixtures/taxonomy.xml')

      output = File.open( "output.html","w" )
      output << LonelyBatcher::NavigationBuilder.transform(xml)
      output.close
    end
  end
end
