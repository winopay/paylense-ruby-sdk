# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Paylense::Collections do
  before(:all) do
    Paylense.configure do |config|
      config.environment = 'sandbox'
      config.version = 'v1'
      config.app_key = 'sand-1-000-0100',
      config.api_secret = 'sec-key-822-4'
    end
  end

  describe 'Collections', vcr: { record: :new_episodes } do
      context "when user has token" do
          it 'makes request to pay' do
            request_to_pay = Paylense::Collections.new.request_to_pay('0775671360',5.0,'6353636', 'testing')
            expect(request_to_pay.status).to eq(:created)
          end
          it 'gets transaction status' do
              ref = '1-paylense-airtel-111111'
              expect { Paylense::Collections.new.get_transaction_status(ref) }
                  .to raise_error(Paylense::Error)
            end
        end
    end

  context "when user is not logged in" do
    it 'fail to get financial status' do
      ref = '1212881'
      expect { Paylense::Collections.new.get_transaction_status(ref) }
          .to raise_error(Paylense::Error)
    end
  end
end
