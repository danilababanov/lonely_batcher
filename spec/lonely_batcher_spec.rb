require 'spec_helper'

describe LonelyBatcher::Processor do

  describe "interface" do
    it "should require 2 args" do
      LonelyBatcher::Processor.should respond_to(:new).with(2).arguments
    end
  end
end
