# frozen_string_literal: true

module ApplicationHelper
  def alert_type_for(flash_type)
    case flash_type.to_sym
    when :alert then :danger
    when :notice then :success
    when :warning then :warning
    else :info
    end
  end
end
