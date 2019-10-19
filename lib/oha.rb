require "oha/version"

module Oha
  def self.included(base)
    base.extend ClassMethods
  end

  NoBlockGivenError = Class.new(StandardError)

  def initialize(*args, &block)
    raise NoBlockGivenError unless block_given?
    @binder = Oha::Binder.new
    yield self
    self
  end

  def bind(event)
    @binder.bind(event)
  end

  module ClassMethods
    def call(*args, &block)
      new(*args, &block)
    end
  end
end
