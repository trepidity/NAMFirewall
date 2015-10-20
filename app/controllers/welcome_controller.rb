class WelcomeController < ApplicationController

  def index
    @rule_session = RuleModel.find_by_session_id(request.session_options[:id])
  end

end
