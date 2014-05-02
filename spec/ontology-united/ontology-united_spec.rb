require 'spec_helper'
require 'uri'

describe OntologyUnited do

  it 'has a version number' do
    expect(OntologyUnited::VERSION).not_to be nil
  end

  context 'when issueing a standard definition' do
    let(:ontology) do
      OntologyUnited::DSL::OntologyDSL.define('Foo') do
        rr = prefix('rr', self)
        imports define('Bar') do
          rr = prefix('rr', self)
          rr.class('SomeBar')
        end
        rr.class('Bar').sub_class_of rr.class('Foo').as(:foo_class)
        rr.class('something')
        rr.class('something').sub_class_of rr.class('Foo')
      end
    end

    it 'should raise no errors' do
      expect { ontology }.not_to raise_error
    end

    it 'should have a valid iri' do
      expect(ontology.iri).to match(URI.regexp)
    end

    it 'should have an on-ontology variable of the right type defined' do
      expect(ontology.foo_class).
        to be_instance_of(OntologyUnited::DSL::OntologyClass)
    end
  end

end
