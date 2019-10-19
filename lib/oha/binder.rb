module Oha
  class Binder
    def bind(event)
      @event = event
      self
    end

    def to(callable_object)
      self
    end
  end
end
