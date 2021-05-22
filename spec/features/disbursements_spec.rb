# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Paylense::Disbursements do
  before(:all) do
    Paylense.configure do |config|
      config.environment = 'sandbox'
      config.version = 'v1'
      config.app_key = 'sand-1-000-0100',
      config.api_secret = 'sec-key-822-4'
    end
  end

  describe 'disbursements', vcr: { record: :new_episodes } do
    it 'makes transfer' do
      expect do
        Paylense::Disbursements.new.transfer(
          '0775671360', 5.0,
          '6353636', 'testing'
        )
      end .to raise_error(Paylense::Error)
    end
  end
  it 'gets transaction status' do
    ref = '88262655522'
    expect { Paylense::Disbursements.new.get_transaction_status(ref) }
      .to raise_error(Paylense::Error)
  end
end
