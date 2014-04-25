# ontology-united

[![Build Status](https://travis-ci.org/0robustus1/ontology-united.svg?branch=master)](https://travis-ci.org/0robustus1/ontology-united)

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

## Usage

First you'll need to require the gem (unless you are using bundler):
```ruby
require 'ontology-united'
```

After doing this you'll be able to create an ontology in two different ways.
Either by explicitly using the defined method:
```ruby
OntologyUnited::DSL::OntologyDSL.define('MyOntologyName') do
end
```

or by including the convience module, which will give you a more
useful/shorter method call:
```ruby
# you'll only need to do this once per namespace
include OntologyUnited::Convience

define_ontology('MyOntologyName') do
end
```

### Building your ontology

Usually there is more than one way to building your ontology, i will
elaborate on the benefits and drawbacks of each method.  However i will now
use the convenience method of building an ontology.

#### Prefix

In order to benefit from ontology-united you'll first need to create a
prefix. As the block passed to `define_ontology` is `instance_eval`ed on the
ontology, self will be the current ontology. So you can create a prefix
which points to the current ontology.
```ruby
define_ontology('MyOntologyName') do
  this = prefix('thisOntology', self)
end
```

However technically you can also pass an IRI (internationalized resource
identifier) instead of `self`. But then you're pretty much on your own.
You'll need to handle iri-management yourself.
```ruby
# Handling iri-management yourself:
define_ontology('MyOntologyName') do
  this = prefix('thisOntology', 'http://example.com/MyOntologyName#')
end
```

#### Class (OWL)

```ruby
define_ontology('MyOntologyName') do
  this = prefix('thisOntology', self)
  this.class('ASampleClass')
end
```

The `.class` method on a prefix, will create a prefixed class inside of the
current ontology. If you do not want to rely on prefixes you can also use
`ontology_class()` but then the argument has to be an IRI instead of a name.
And again (as with prefixes) your currently on your own for
iri-management.


```ruby
# Handling iri-management yourself:
define_ontology('MyOntologyName') do
  ontology_class('http://example.com/MyOntology#ASampleClass')
end
```

By the way, you do not need to store ontology classes inside variables in
order to use them again (i.e. in sentences). You can just *define* them
again. The system will figure out by itself, that you actually meant the
same class.

#### Sentence

Currently ontology-united only supports `sub_class_of` sentences.  This will
be extended in the future, but it *has* to be enough for now.

```ruby
define_ontology('MyOntologyName') do
  this = prefix('thisOntology', self)
  this.class('ASampleClass').sub_class_of this.class('AParentClass')
end
```

#### Imports

You can define ontologies inside of other ontologies, through the inner
`define`-method, which works exactly as the standard `define` method (also
called `define_ontology` in convenience mode).

```ruby
define_ontology('Foo') do
  this = prefix('this', self)
  define('Bar') do
    rr = prefix('rr', self)
    rr.class('SomeBar')
  end
  this.class('Bar').sub_class_of this.class('Foo')
  this.class('something')
  this.class('something').sub_class_of this.class('Foo')
end
```

As you might've guessed this is pretty useful when using imports, as this
would allow you to import an ontology which you just defined *in-place*.
Let's take a look at this:

```ruby
define_ontology('Foo') do
  import define('Bar') do
    rr = prefix('rr', self)
    rr.class('SomeBar')
  end
  this.class('Bar').sub_class_of this.class('Foo')
end
```

The `import` method is key, and that is basically it.


### Serialization

Let's assume we have an ontology:

```ruby
ontology = define_ontology('Foo') do
  rr = prefix('rr', self)
  imports define('Bar') do
    rr = prefix('rr', self)
    rr.class('SomeBar')
  end
  rr.class('Bar').sub_class_of rr.class('Foo')
  rr.class('something')
  rr.class('something').sub_class_of rr.class('Foo')
end
```

If we want to work with it, we can query it for its IRI like this:
`ontology.iri`, which will return a `file://`-schema IRI.

If we want access to the `Tempfile` (which ontology-united uses internally),
we can call `ontology.file`.

Both methods will ensure that the corresponding file is created and
serialized, including all imported ontologies.

