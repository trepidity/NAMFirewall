class BuildRulesController < ApplicationController

  def destroy
    flash[:notice] = 'Successfully cleared all rules' if RuleModel.destroy_all(:session_id => session[:session_hex])
  end

  # show the rules
  def show
    @rule_model = RuleModel.find_by_session_id(session[:session_hex])
  end

end
