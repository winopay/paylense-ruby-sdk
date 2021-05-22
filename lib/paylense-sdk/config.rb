# frozen_string_literal: true

# Configurations are set up in this file
# for a user's Paylense API user credentials

module Paylense
  class Config
    attr_accessor :environment, :version, :app_key, :api_secret

    def initialize
      @environment = nil
      @version = nil
      @api_key = nil
      @api_secret = nil
    end

  end
end
