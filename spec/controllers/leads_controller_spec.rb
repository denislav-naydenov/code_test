# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeadsController do
  describe 'GET new' do
    it 'renders the template' do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
