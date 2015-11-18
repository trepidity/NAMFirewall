class WelcomeController < ApplicationController

  def index
    hex = session[:session_hex]

    if hex.nil?
      hex = SecureRandom.hex
      session[:session_hex] = hex
    end

    @rule_session = RuleModel.find_or_create_by!(:session_id => hex)
  end

end
