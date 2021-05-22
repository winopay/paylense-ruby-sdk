# frozen_string_literal: true

require 'paylense-sdk/config'
require 'paylense-sdk/version'
require 'paylense-sdk/collections'
require 'paylense-sdk/disbursements'

module Paylense
  class << self
    attr_accessor :config
  end

  def self.config
    @config ||= Config.new
  end

  def self.reset
    @config = Config.new
  end

  def self.configure
    yield(config)
  end
end
