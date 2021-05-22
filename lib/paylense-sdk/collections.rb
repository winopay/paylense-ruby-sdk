# frozen_string_literal: true

# Implementation of the Paylense API collections client

require 'securerandom'

require 'paylense-sdk/config'
require 'paylense-sdk/client'
require 'paylense-sdk/validate'

module Paylense
  class Collections < Client
    # This method is used to request a payment from a Payer
    # The payer will be asked to authorize the payment. The transaction will
    # be executed once the payer has authorized the payment.
    # The request to pay will be in status PENDING until the transaction
    # is authorized or declined by the payer or it is timed out by the system.
    # The status of the transaction is received via the webhook

    def request_to_pay(api_key,account_number, amount, merchant_reference, payment_method, provider, currency,
                       encrypted_card ='', narration = '', account_name = '', account_email ='', redirect_url = '', callback_url = '')
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
        "encrypted_card": encrypted_card,
        "account_name": account_name,
        "account_email": account_email,
        "redirect_url": redirect_url,
        "callback_url": callback_url
      }
      path = '/request-to-pay'
      send_request('collections', 'post', path, body)
      #{ transaction_reference: uuid }
    end

  end
end
