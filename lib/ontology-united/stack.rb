module OntologyUnited
  module Stack

    def stack
      @stack ||= []
    end

    def current
      stack[-1]
    end

    def parent
      stack[-2]
    end

    module Delegate
      def delegate_stack_to(method_name=nil, &block)
        action = ->(stack_operation) do
          ->() do
            block.call(self).send(stack_operation)
          end
        end
        define_method :stack, &action[:stack]
        define_method :current, &action[:current]
        define_method :parent, &action[:parent]
      end
    end

  end
end
