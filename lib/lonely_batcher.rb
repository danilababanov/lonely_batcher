require "lonely_batcher/version"

module LonelyBatcher

  class Processor
    def initialize(taxonomy, destinations)
      puts taxonomy.inspect
      puts destinations.inspect
    end
  end
end
