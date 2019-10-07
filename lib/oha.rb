require "oha/version"

module Oha
  def self.included(base)
    base.extend ClassMethods
  end

  NoBlockGivenError = Class.new(StandardError)

  def initialize(*args, &block)
    raise NoBlockGivenError unless block_given?
    self
  end

  module ClassMethods
    def call(*args, &block)
      new(*args, &block)
    end
  end
end
