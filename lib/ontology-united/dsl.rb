module OntologyUnited
  module DSL
    class Error < ::StandardError; end
    class NotImplementedError < Error; end

    def self.define_ontology

    end
  end
end

require "ontology-united/dsl/pseudo_set.rb"
require "ontology-united/dsl/variable_store.rb"
require "ontology-united/dsl/base_dsl"
require "ontology-united/dsl/ontology_dsl"
require "ontology-united/dsl/ontology_entity_base"
require "ontology-united/dsl/ontology"
require "ontology-united/dsl/ontology_class"
require "ontology-united/dsl/ontology_import"
require "ontology-united/dsl/ontology_prefix"
require "ontology-united/dsl/ontology_sentence"
