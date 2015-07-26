$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'lonely_batcher'
require 'pry'
require 'rspec-html-matchers'

RSpec.configure do |config|
  config.include RSpecHtmlMatchers
  config.after(:all) do
   
    FileUtils.rm_rf 'tmp'

  end
end
