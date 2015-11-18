class BuildRulesController < ApplicationController

  def destroy
    rule_session = RuleModel.find_by_session_id(session[:session_hex])
    flash[:notice] = 'Successfully cleared all rules' if rule_session.nam_components.delete_all
  end

  # show the rules
  def show
    @rule_model = RuleModel.find_by_session_id(session[:session_hex])
  end

end
