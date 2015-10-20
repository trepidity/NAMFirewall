class WelcomeController < ApplicationController

  def index
    @rule_session = RuleModel.find_or_create_by(:session_id => request.session_options[:id])
  end

end
