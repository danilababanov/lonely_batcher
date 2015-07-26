# LonelyBatcher

This gem translates destinations xml and taxonomy xml into html files using a specific output template and collects said html files into an output directory.

## Dependencies

Requirements: Git and Ruby 1.9.3 or greater.

## Installation

Clone the repository by executing:

    $ git clone git@github.com:rudedoc/lonely_batcher.git

Install dependencies:

    $ cd lonely_batcher && bundle install

## Usage

The program is accessible via an irb session. Use the provided rake command to launch an irb session with the gem loaded:

    $ rake console

To process some files run the following in the irb session created above:

```ruby
  taxonomy_file = File.open('spec/fixtures/taxonomy.xml')
  destinations_file = File.open('spec/fixtures/destinations.xml')
  batcher = LonelyBatcher::Processor.new(taxonomy_file, destinations_file, 'temp')
  batcher.perform # generates files in the temp directory
```

this will generate a folder containing the html files and supporting css.

## Implementation details
The program is implemented as a rubygem using Bundler conventions for gem building. The program is broken into 3 separate classes. The Processor class is the main class and calls on the NaviagationBuilder and PageBuilder to construct a page for each destination. The NavigationBuilder uses the taxonomy.xml data to construct a navigation html element which is identical for each destination page. The PageBuilder constructs a page using a destination xml node from the destinations.xml file and the navigation html from the NavigationBuilder. The Processor iterates through each destination node in the destinations.xml file and creates a file for each destination in the output folder location that is provided.

### NavigationBuilder
The navigation builder as a subclass of RSLT::Stylesheet provided by the [The RSLT library](https://github.com/DanielHeath/rslt). Each destination in the navigation is given a href which is that destination's atlas_id as specified in the taxonomy.xml file.

### PageBuilder
The PageBuilder inserts destination name, content and navigation into a copy of the output example html file provided.

### Processor
Iterates through each destination in the destinations.xml file, uses NavigationBuilder and PageBuilder to construct a page for each destination and creates a html file with the name of the file on disk being the atlas_id of the destination. Basic error handling has been implemented to allow the Processor to continue processing more destinations if, for some reason, it encounters something it doesn't like.

## Testing
Testing framework is RSpec. Unit Testing of the instance methods are provided in the spec folder. Unit Tests of the Processor class also act as integration tests as they exercise all parts of the program together. The provided destinations.xml and taxonomy.xml files were used as fixtures for the tests.

To run the test suite:

    $ cd lonely_batcher
    $ bundle install
    $ rspec

## Thank You
Many thanks to the person who is taking the time to review this test. All comments positive or otherwise are greatly appreciated.
