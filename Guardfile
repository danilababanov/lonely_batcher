
guard :rspec, cmd: "bundle exec rspec" do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  watch('lib/lonely_batcher/navigation_builder.rb') { |m| "spec/navigation_builder_spec.rb" }
  watch('lib/lonely_batcher/page_builder.rb') { |m| "spec/page_builder_spec.rb" }
  watch('lib/lonely_batcher/processor.rb') { |m| "spec/processor_spec.rb" }

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)
end
