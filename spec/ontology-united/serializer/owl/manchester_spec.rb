require 'spec_helper'

describe OntologyUnited::Serializer::OWL::Manchester do
  let(:manchester) { OntologyUnited::Serializer::OWL::Manchester }
  let(:name) { 'OntologyName' }
  let(:list) do
    the_prefix, ontology_class, sentence = nil
    o = OntologyUnited::DSL::OntologyDSL.define("#{name}.owl") do
      the_prefix = prefix('some', self)
      ontology_class = the_prefix.class('Foobar')
      sentence = ontology_class.sub_class_of the_prefix.class('NoBar')
    end
    [o, the_prefix, ontology_class, sentence]
  end
  let(:ontology) { list[0] }
  let(:prefix) { list[1] }
  let(:ontology_class) { list[2] }
  let(:sentence) { list[3] }

  context 'when serializing an ontology' do
    let(:serialized) { ontology.to_s(serializer: manchester.new) }

    it 'should contain the prefix definition' do
      expect(serialized).to include(prefix.to_s(serializer: manchester.new))
    end

    it 'should contain the ontology class definition' do
      expect(serialized).to include(ontology_class.to_s(serializer: manchester.new))
    end

    it 'should contain the sentence definition' do
      expect(serialized).to include(sentence.to_s(serializer: manchester.new))
    end
  end

  context 'when serializing an ontology class' do
    let(:serialized) { ontology_class.to_s(serializer: manchester.new) }

    it 'should be a valid manchester syntax class definition' do
      expect(serialized).to eq("Class: some:Foobar")
    end
  end

  context 'when serializing a prefix' do
    let(:serialized) { prefix.to_s(serializer: manchester.new) }

    it 'should be a valid manchester syntax prefix definition' do
      expect(serialized).to match(/^Prefix: some: <[^>]+#>$/)
    end
  end

  context 'when serializing a sentence' do
    let(:serialized) { sentence.to_s(serializer: manchester.new) }

    it 'should be a valid manchester syntax sentence definition' do
      expect(serialized).to eq("Class: some:Foobar SubClassOf: Class: some:NoBar")
    end
  end

end
