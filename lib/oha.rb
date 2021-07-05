require 'oha/version'
require 'oha/binder'
require 'oha/errors/no_block_given_error'
require 'oha/errors/event_not_defined'

# Main Module that defines all the behaviour
# that will be added to a UseCase
module Oha
  def self.included(base)
    base.extend ClassMethods
  end

  def initialize(*args)
    raise Oha::Errors::NoBlockGivenError unless block_given?

    @binder = Oha::Binder.new(self)
    @callbacks = {}
    @params = args
    yield @binder
    self
  end

  def set_callback(event, callable)
    @callbacks[event.to_sym] = callable
    self
  end

  def trigger(event)
    callback = @callbacks.fetch(event.to_sym) { raise Oha::Errors::EventNotDefined }
    callback.call
  end

  # Class methods to be added to a UseCase.
  module ClassMethods
    def call(*args, &block)
      new(*args, &block)
    end
  end
end
