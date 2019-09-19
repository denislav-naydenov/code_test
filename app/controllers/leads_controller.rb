# frozen_string_literal: true

class LeadsController < ApplicationController
  def new
    @lead_form = LeadForm.new
  end

  def create
    @lead_form = LeadForm.new(lead_form_params)

    if @lead_form.submit
      notice = 'Thank you! Your request was submitted successfully and that Makeitcheaper will contact you'
      redirect_to(new_lead_path, notice: notice)
    else
      flash.now[:alert] = @lead_form.errors.full_messages
      render :new
    end
  end

  private

  def lead_form_params
    params.require(:lead_form).permit(:name, :business_name, :telephone_number,
                                      :email, :contact_time, :notes, :reference)
  end
end
