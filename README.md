# LonelyBatcher

This gem provides translating destinations xml and taxonomy xml into html files using a specific output template and collects said html files into an output directory. 

## Installation

Requirements: Git and Ruby 1.9.3 or greater.

Clone the repository by excuting:

    $ git clone git@github.com:rudedoc/lonely_batcher.git

Install depencencies:

    $ cd lonely_batcher && bundle install

## Usage

The program is accessable via an irb session. Use the provided rake command to launch an irb session with the gem loaded:

    $ rake console

To process some files run the following in the irb session:

```ruby
  LonelyBatcher::Processor.new('desinations.xml', 'taxonomy.xml', '/path/to/output/directory')
```

This will generate a folder containing the html files and supporting css.
