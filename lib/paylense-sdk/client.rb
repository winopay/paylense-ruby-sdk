# frozen_string_literal: true

# Base implementation of the Paylense API client

# Includes methods common to collections, disbursements

require 'faraday'

require 'paylense-sdk/config'
require 'paylense-sdk/errors'

module Paylense
  class Client
    def send_request(service, method, path, body = {})
      begin
        conn = create_connection(service)
        relative_path = "/api/#{Paylense.config.version}#{path}"

        case method
          when 'get'
            response = conn.get(relative_path)
          when 'post'
            response = conn.post(relative_path, body.to_json)
        end
      rescue ArgumentError
        raise 'Missing configuration key(s)'
      end
      interpret_response(response)
    end

    def interpret_response(resp)
      body = resp.body.empty? ? '' : JSON.parse(resp.body)

      response = {
        body: body,
        code: resp.status
      }
      unless resp.status >= 200 && resp.status < 300
        handle_error(response[:body], response[:code])
      end

      body
    end

    def handle_error(response_body, response_code)
      raise Paylense::Error.new(response_body, response_code)
    end

    # set authorization and authentication
    def create_connection(service)
      url = "https://#{service}.paylense.com" if Payhere.config.environment.eql? 'production'
      url = "https://sandbox#{service}.paylense.com" if Payhere.config.environment.eql? 'sandbox'

      headers = {
        "Content-Type": 'application/json',
        "Accept": 'application/json'
      }

      conn = Faraday.new(url: url)
      conn.headers = headers

      get_credentials
      conn.authorization @access_token
      conn.headers['Secret-Key'] = @secret_key

      conn
    end

    def get_credentials
      @secret_key = Paylense.config.secret_key
      @access_token = Paylense.config.access_token
    end

    # retrieve transaction information
    def get_transaction_status(path)
      send_request('get', path)
    end
  end
end
