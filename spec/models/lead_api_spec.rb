# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeadAPI do
  describe '#create' do
    subject { api.create(params) }

    let(:api) { described_class.new }

    context 'with valid params' do
      let(:params) do
        {
          name: 'John Doe',
          business_name: 'Company Ltd',
          telephone_number: '+440000000000',
          email: 'john.doe@example.com',
          contact_time: '2019-09-18 00:00:00',
          notes: 'some notes',
          reference: '123'
        }
      end

      around(:each) do |example|
        VCR.use_cassette 'successful_api_request' do
          example.run
        end
      end

      it 'returns successful response' do
        expect(subject).to eq(
          'success' => true,
          'message' => 'Enqueue success',
          'errors' => []
        )
      end
    end

    context 'with invalid params' do
      let(:params) { {} }

      around(:each) do |example|
        VCR.use_cassette 'failed_api_request' do
          example.run
        end
      end

      it 'returns error response' do
        expect(subject).to eq(
          'success' => false,
          'message' => 'Format errors on validation',
          'errors' => [
            "Field 'name' isn't present",
            "Field 'name' is blank",
            "Field 'name' wrong format, 'name' must be composed with 2 separated words (space between)",
            "Field 'business_name' isn't present",
            "Field 'business_name' is blank",
            "Field 'telephone_number' isn't present",
            "Field 'telephone_number' is blank",
            "Field 'telephone_number' wrong format (must contain have valid phone number with 11 numbers. string max 13 chars)",
            "Field 'email' isn't present",
            "Field 'email' is blank",
            "Field 'email' wrong format"
          ]
        )
      end
    end

    context 'without authentication params' do
      let(:params) { {} }

      before do
        allow(api).to receive(:authentication_params).and_return({})
      end

      around(:each) do |example|
        VCR.use_cassette 'no_authentication_api_request' do
          example.run
        end
      end

      it 'returns error response' do
        expect(subject).to eq(
          'success' => false,
          'message' => 'Unauthorised access_token'
        )
      end
    end
  end
end
