# frozen_string_literal: true

class LeadForm
  include ActiveModel::Model

  attr_accessor :name, :business_name, :telephone_number, :email,
                :contact_time, :notes, :reference

  def submit
    true
  end
end
