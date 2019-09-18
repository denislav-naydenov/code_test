# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeadForm do
  subject { described_class.new(params) }
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

  describe '#submit' do
    it 'returns true' do
      expect(subject.submit).to be true
    end
  end
end
