# frozen_string_literal: true

# Implementation of Paylense API disbursements client

require 'paylense-sdk/config'
require 'paylense-sdk/client'

module Paylense
  class Disbursements < Client
    # The transfer operation is used to transfer an amount from the payer's
    # account to a payee account.
    # The status of the transaction can be validated
    # by using `get_transation_status`
    def transfer(api_key, account_number, amount, merchant_reference, payment_method, provider, currency,
                 narration = '', account_name = '', account_email ='', redirect_url = '', callback_url = '',
                 extra_provider_detail = {})
      Paylense::Validate.new.validate(account_number, amount)
      merchant_reference = SecureRandom.uuid unless merchant_reference.blank?

      body = {
        "account_number": account_number,
        "narration": narration,
        "merchant_reference": merchant_reference,
        "amount": amount.to_i,
        "api_key": api_key,
        "payment_method": payment_method,
        "provider": provider,
        "currency": currency,
        "account_name": account_name,
        "account_email": account_email,
        "redirect_url": redirect_url,
        "callback_url": callback_url,
        "extra_provider_detail": extra_provider_detail
      }
      path = '/transfer'

      send_request('post', path, body)
      { merchant_reference: merchant_reference }
    end

  end
end
