module OntologyUnited
  module DSL
    class PseudoSet < ::Array

      alias_method :array_push, :push
      alias_method :array_concat, :concat

      def add_or_fetch(obj)
        if include?(obj)
          at(index(obj))
        else
          array_push(obj)
          obj
        end
      end

      def push(obj)
        include?(obj) ? self : array_push(obj)
      end

      def <<(obj)
        push(obj)
      end

      def concat(arr)
        array = dup
        arr.each { |el| array.push(el) }
        array
      end

      def +(arr)
        concat(arr)
      end


    end
  end
end
