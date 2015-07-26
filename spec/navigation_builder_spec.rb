require 'spec_helper'

describe LonelyBatcher::NavigationBuilder do
  describe ".transform" do
    before do
      xml = <<-XML
        <taxonomies>
          <taxonomy>
            <taxonomy_name>World</taxonomy_name>
            <node atlas_node_id="355064" ethyl_content_object_id="82534" geo_id="355064">
              <node_name>Africa</node_name>
              <node atlas_node_id="355611" ethyl_content_object_id="3210" geo_id="355611">
                <node_name>South Africa</node_name>
                <node atlas_node_id="355612" ethyl_content_object_id="35474" geo_id="355612">
                  <node_name>Cape Town</node_name>
                  <node atlas_node_id="355613" ethyl_content_object_id="" geo_id="355613">
                    <node_name>Table Mountain National Park</node_name>
                  </node>
                </node>
              </node>
            </node>
          </taxonomy>
        </taxonomies>
      XML
      @navigation = LonelyBatcher::NavigationBuilder.transform(xml)
    end

    it "should have div, ul and li tags" do
      expect(@navigation).to have_tag('div') do
        with_tag "div", count: 1
        with_tag "ul", count: 4
        with_tag "li", count: 4
      end
    end

    it "should put a tag inside li tags" do
      expect(@navigation).to have_tag('li a')
    end

    it "should put the atlas_id into the href tag" do
      expect(@navigation).to have_tag('a', with: { href: '355613.html'})
    end

    it "should nest uls 4 deep" do
      expect(@navigation).to have_tag('ul ul ul ul')
    end
  end
end
