# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeadsController do
  describe 'GET new' do
    it 'renders the template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
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

      it 'redirects to new' do
        post :create, params: { lead_form: params }

        expect(response).to redirect_to(new_lead_path)
      end

      it 'adds flash notice' do
        post :create, params: { lead_form: params }

        expect(flash[:notice]).to eq('Thank you! Your request was submitted successfully and that Makeitcheaper will contact you')
      end
    end
  end

  context 'with invalid params' do
    let(:params) { { name: 'John Doe' } }

    around(:each) do |example|
      VCR.use_cassette 'name_only_api_request' do
        example.run
      end
    end

    it 'renders new' do
      post :create, params: { lead_form: params }

      expect(response).to render_template(:new)
    end

    it 'adds flash alert' do
      post :create, params: { lead_form: params }

      expect(flash[:alert]).to match_array(["Field 'business_name' is blank",
                                            "Field 'telephone_number' is blank",
                                            "Field 'telephone_number' wrong format (must contain have valid phone number with 11 numbers. string max 13 chars)",
                                            "Field 'email' is blank",
                                            "Field 'email' wrong format"])
    end
  end

  context 'when an error happens' do
    let(:params) { { name: 'John Doe' } }

    before do
      allow_any_instance_of(LeadForm).to receive(:submit).and_raise(StandardError, 'API is down')
    end

    it 'logs the error' do
      expect(Rails.logger).to receive(:error).with(instance_of(StandardError))

      post :create, params: { lead_form: params }
    end

    it 'renders new' do
      post :create, params: { lead_form: params }

      expect(response).to render_template(:new)
    end

    it 'adds flash alert' do
      post :create, params: { lead_form: params }

      expect(flash[:alert]).to eq('An error occurred while submitting your input. Please call us by the phone.')
    end
  end
end
