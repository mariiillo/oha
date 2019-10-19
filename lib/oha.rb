require "oha/version"

module Oha
  def self.included(base)
    base.extend ClassMethods
  end

  NoBlockGivenError = Class.new(StandardError)

  def initialize(*args, &block)
    raise NoBlockGivenError unless block_given?
    @mappings = Hash.new
    yield self
    self
  end

  def bind(event)
    Oha::Binder.new(event)
  end

  module ClassMethods
    def call(*args, &block)
      new(*args, &block)
    end
  end
end
