require 'oha/version'
require 'oha/errors/no_block_given_error'

# Main Module that defines all the behaviour
# that will be added to a UseCase
module Oha
  def self.included(base)
    base.extend ClassMethods
  end

  def initialize(*args)
    raise Oha::Errors::NoBlockGivenError unless block_given?

    @binder = Oha::Binder.new(self)
    @params = args
    yield self
    self
  end

  # Class methods to be added to a UseCase.
  module ClassMethods
    def call(*args, &block)
      new(*args, &block)
    end
  end
end
