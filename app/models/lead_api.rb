# frozen_string_literal: true

class LeadAPI
  include HTTParty

  base_uri ENV.fetch('LEAD_API_URI')

  def create(params)
    params.merge!(authentication_params)
    response = LeadAPI.post('/api/v1/create', query: params)

    response.parsed_response.merge(
      'success' => response.code == 201
    )
  end

  def authentication_params
    {
      access_token: ENV.fetch('LEAD_API_ACCESS_TOKEN'),
      pGUID: ENV.fetch('LEAD_API_PGUID'),
      pAccName: ENV.fetch('LEAD_API_PACCNAME'),
      pPartner: ENV.fetch('LEAD_API_PPARTNER')
    }
  end
end
