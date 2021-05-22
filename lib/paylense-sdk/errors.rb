# frozen_string_literal: true

# Error handling for unsuccessful responses from Paylense API

module Paylense
  class Error < StandardError
    def initialize(message, code)
      @code = code
      super("Error code #{code} #{message}")
    end
  end

  class ValidationError < StandardError
    def initialize(msg = message)
      super(msg)
    end
  end
end
