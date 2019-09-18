# frozen_string_literal: true

class LeadForm
  include ActiveModel::Model

  attr_accessor :name, :business_name, :telephone_number, :email,
                :contact_time, :notes, :reference

  def submit
    result = lead_api.create(to_h)
    return true if result['success']

    if result['errors'].blank?
      errors.add(:base, result['message'])
    else
      result['errors'].each { |error| errors.add(:base, error) }
    end

    false
  end

  def to_h
    {
      name: name,
      business_name: business_name,
      telephone_number: telephone_number,
      email: email,
      contact_time: contact_time,
      notes: notes,
      reference: reference
    }
  end

  private

  def lead_api
    @lead_api ||= LeadAPI.new
  end
end
