# ontology-united

ontology-united is a small DSL (domain specific language) for
writing [OWL][owl] ontologies.

It is mainly intended as a gem to be used as part of
the [ontohub][ontohub] project to create ontologies for testing in
order to not rely on fixtures. See the corresponding issue
(ontohub/ontohub#786).

Currently it supports only the [manchester syntax][manchester]
as serialization
mechanism and is fairly limited in its owl support.
However it will be further developed, maintained and extended.

[owl]: http://www.w3.org/TR/owl2-overview/
[ontohub]: https://github.com/ontohub/ontohub
[manchester]: http://www.w3.org/2007/OWL/wiki/ManchesterSyntax

## Installation

Add this line to your application's Gemfile:

    gem 'ontology-united'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ontology-united

