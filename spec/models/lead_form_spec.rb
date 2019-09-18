# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeadForm do
  subject { described_class.new(params) }

  let(:params) { {} }

  describe '#submit' do
    let(:lead_api) { instance_double(LeadAPI) }

    before do
      allow(subject).to receive(:lead_api).and_return(lead_api)
      allow(lead_api).to receive(:create).and_return(api_response)
    end

    context 'with successful creation' do
      let(:api_response) do
        {
          'success' => true,
          'message' => 'Enqueue success',
          'errors' => []
        }
      end

      it 'returns true' do
        expect(subject.submit).to be true
      end

      it 'does not assign errors to the form' do
        subject.submit
        expect(subject.errors).to be_empty
      end
    end

    context 'with failed creation' do
      let(:api_response) do
        {
          'success' => false,
          'message' => 'Format errors on validation',
          'errors' => [
            "Field 'name' isn't present",
            "Field 'name' is blank"
          ]
        }
      end

      it 'returns false' do
        expect(subject.submit).to be false
      end

      it 'assigns errors to the form' do
        subject.submit
        expect(subject.errors).to match_array(api_response['errors'])
      end
    end

    context 'with failed creation and no errors' do
      let(:api_response) do
        {
          'success' => false,
          'message' => 'Format errors on validation'
        }
      end

      it 'returns false' do
        expect(subject.submit).to be false
      end

      it 'assigns the message as error to the form' do
        subject.submit
        expect(subject.errors).to match_array([api_response['message']])
      end
    end
  end

  describe '#to_h' do
    context 'with empty params' do
      it 'returns a hash with nil values for each field' do
        expect(subject.to_h).to eq(
          name: nil,
          business_name: nil,
          telephone_number: nil,
          email: nil,
          contact_time: nil,
          notes: nil,
          reference: nil
        )
      end
    end

    context 'with non-empty params' do
      let(:params) do
        {
          name: 'a name',
          business_name: 'a business',
          telephone_number: 'a phone',
          email: 'an email',
          contact_time: nil,
          notes: nil,
          reference: nil
        }
      end

      it 'returns the params' do
        expect(subject.to_h).to eq(params)
      end
    end
  end
end
