module Oha
  module Errors
    # This error will be raised if no callbacks
    # are passed to the UseCase.
    class NoBlockGivenError < StandardError; end
  end
end
