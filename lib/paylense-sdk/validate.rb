# frozen_string_literal: true

# Validations for parameters passed into client methods

require 'paylense-sdk/errors'

module Paylense
  class Validate
    def validate(account_number, amount)
      validate_string?(account_number, 'Phone number')
      validate_numeric?(amount, 'Amount')
    end

    def validate_numeric?(num, field)
      return true if num.is_a? Numeric

      raise Paylense::ValidationError, "#{field} should be a number"
    end

    def validate_string?(str, field)
      return true if str.is_a? String

      raise Paylense::ValidationError, "#{field} should be a string"
    end
  end
end
