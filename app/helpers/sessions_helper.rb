# frozen_string_literal: true

module SessionsHelper
  def session_symbol(name)
    path = request.fullpath.split("/")
    "#{path.second_to_last}_#{path.last}_#{name}"
  end
end
