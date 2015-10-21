class WelcomeController < ApplicationController

  def index
    hex = session[:session_hex]

    if hex.nil?
      hex = SecureRandom.hex
      p "generated hex #{hex}"
      session[:session_hex] = hex
    else
      p "found hex #{hex}"
    end

    @rule_session = RuleModel.find_or_create_by!(:session_id => hex)
    p "loading RuleModel #{@rule_session.inspect}"
  end

end
