module OntologyUnited
  module Convenience

    def define_ontology(*args, &block)
      OntologyUnited::DSL::OntologyDSL.define(*args, &block)
    end

  end
end
