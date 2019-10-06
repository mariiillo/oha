require "oha/version"

module Oha
  def self.included(base)
    base.extend ClasMethods
  end

  NoBlockGivenError = Class.new(StandardError)

  def initialize(*args, &block)
    raise NoBlockGivenError unless block_given?
    self
  end

  module ClasMethods
    def call(*args, &block)
      new(*args, &block)
    end
  end
end
