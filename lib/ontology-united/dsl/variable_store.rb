module OntologyUnited
  module DSL
    module VariableStore
      class Error < ::StandardError; end
      class ParentIsNilError < Error; end

      module Helper
        def as(name)
          fail ParentIsNilError, 'Can\'t define variable on nil' unless parent
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
