module Oha
  class Binder
    def initialize(event)
      @event = event
    end

    def to(callable_object)
      self
    end
  end
end
