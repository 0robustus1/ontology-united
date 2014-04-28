module OntologyUnited
  module DSL
    class OntologyEntityBase

      attr_reader :the_calls

      def self.delegate_equality_to(method: nil, variable: nil)
        define_method :== do |obj|
          if method
            self.send(method.to_sym) == obj.send(method.to_sym)
          elsif variable
            own = self.instance_variable_get(:"@#{variable}")
            other = obj.instance_variable_get(:"@#{variable}")
            own == other
          end
        end
        define_method :eql? do |obj|
          self == obj
        end
        define_method :hash do
          if method
            self.send(method).hash
          elsif variable
            self.instance_variable_get(:"@#{variable}")
          end
        end

      end

      def parent
        OntologyDSL.current
      end

    end
  end
end
