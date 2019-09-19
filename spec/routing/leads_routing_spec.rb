# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes for leads' do
  it 'routes to new' do
    expect(get('/leads/new')).to route_to(controller: 'leads', action: 'new')
  end

  it 'routes to create' do
    expect(post('/leads')).to route_to(controller: 'leads', action: 'create')
  end
end
