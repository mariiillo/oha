module Oha
  # This clas contains the logic to map events to actions
  class Binder
    def initialize(context)
      @context = context
    end

    def bind(event)
      @event = event
      self
    end

    def to(_callable_object)
      self
    end
  end
end
