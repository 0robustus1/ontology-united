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

  end
end
