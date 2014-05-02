module OntologyUnited
  module DSL
    module VariableStore

      module Helper
        def as(name)
          parent.declare(self, as: name.to_sym)
          self
        end
      end

      module Declaration
        def declare(obj, as: nil)
          if as
            define_singleton_method(as) { obj }
          end
        end
      end

    end
  end
end
