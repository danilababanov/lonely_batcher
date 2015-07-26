require 'spec_helper'

describe LonelyBatcher::PageBuilder do

  describe "#build" do

    before do
      xml = <<-XML 
      <destination atlas_id="123456" asset_id="22614-4" title="Here" title-ascii="Here">
        <history>
          <history></history>
        </history>
        <introductory>
          <introduction>All About The Place</introduction>
        </introductory>
        <practical_information></practical_information>
        <transport></transport>
        <weather></weather>
        <work_live_study></work_live_study>
      </destination>
      XML
      destination = Nokogiri::XML(xml)
      @navigation = "<div><ul><li><a href='#'>Link</a></li></ul></div>"
      @page = LonelyBatcher::PageBuilder.new(destination, @navigation).build
    end

    it "should create a html document" do
      expect(@page).to have_tag "html body"
    end

    it "should put the destination title into the page" do
      expect(@page).to have_tag "div.secondary-navigation ul li a", text: 'Here'
    end

    it "should put the introduction into the body of the page" do
      expect(@page).to include("All About The Place")
    end

    it "should include the navigation in the page" do
      expect(@page).to include(@navigation)
    end
  end
end

